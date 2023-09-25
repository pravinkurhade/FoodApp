import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/menu.dart';
import '../../models/menu_response.dart';
import '../../networking/rest_client.dart';

part 'Cart_event.dart';

part 'Cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final client = RestClient(Dio(BaseOptions(contentType: 'application/json')));

  CartBloc() : super(MenuInitial());
  late Map<String, int> cartMenus = HashMap();
  late List<Menu> menus;

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {

    if (event is GetCartMenuEvent) {
      try {
        yield LoadingState();
        var cartMap = event.cartMenus;
        cartMenus = cartMap;

        final String response =
        await rootBundle.loadString('assets/sample.json');
        final data = await json.decode(response);
        final menuResponse = MenuResponse.fromJson(data);
        menus = menuResponse.menu.where((i) => cartMenus.containsKey(i.$oid)).toList();
        var total = 0;
        for (var i = 0; i < menus.length; i++) {
          if(cartMenus.containsKey(menus[i].$oid)){
            var price = ((menus[i].price) as int ) * cartMap[menus[i].$oid]!;
            total = total + price;
          }
        }
        yield CartMenuLoaded(menuResponse: menus, cart: cartMenus,total: total);
      } catch (e) {
        ErrorState(message: e.toString());
      }
    }

    if (event is AddToCartEvent) {
      try {
        yield LoadingState();
        var id = event.id;
        cartMenus.update(id, (v) => (v + 1), ifAbsent: () => 1);
        if (kDebugMode) {
          print(cartMenus.toString());
        }
        var total = 0;
        for (var i = 0; i < menus.length; i++) {
          if(cartMenus.containsKey(menus[i].$oid)){
            var price = ((menus[i].price) as int ) * cartMenus[menus[i].$oid]!;
            total = total + price;
          }
        }

        yield CartMenuLoaded(menuResponse: menus, cart: cartMenus,total: total);
      } catch (e) {
        ErrorState(message: e.toString());
      }
    }

    if (event is RemoveFromCartEvent) {
      try {
        yield LoadingState();
        var id = event.id;
        var count = cartMenus[id];
        if (count != null) {
          if (count == 1) {
            for (var i = 0; i < menus.length; i++) {
              if(menus[i].$oid == id){
               menus.remove(i);
              }
            }
            cartMenus.remove(id);
          } else {
            cartMenus.update(id, (v) => (v - 1), ifAbsent: () => 0);
          }
        } else {
          cartMenus.update(id, (v) => (v - 1), ifAbsent: () => 0);
        }
        if (kDebugMode) {
          print(cartMenus.toString());
        }
        var total = 0;
        for (var i = 0; i < menus.length; i++) {
          if(cartMenus.containsKey(menus[i].$oid)){
            var price = ((menus[i].price) as int ) * cartMenus[menus[i].$oid]!;
            total = total + price;
          }
        }
        yield CartMenuLoaded(menuResponse: menus, cart: cartMenus,total: total);
      } catch (e) {
        ErrorState(message: e.toString());
      }
    }
  }
}
