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

part 'Menu_event.dart';

part 'Menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final client = RestClient(Dio(BaseOptions(contentType: 'application/json')));

  MenuBloc() : super(MenuInitial());
  late Map<String, int> cartMenus = HashMap();
  late List<Menu> menus;

  @override
  Stream<MenuState> mapEventToState(
    MenuEvent event,
  ) async* {
    if (event is GetMenuEvent) {
      try {
        yield LoadingState();

        //var responseData = await client.getMenu();

        //local call
        final String response =
            await rootBundle.loadString('assets/sample.json');
        final data = await json.decode(response);
        final menuResponse = MenuResponse.fromJson(data);
        menus = menuResponse.menu;
        yield MenuLoaded(menuResponse: menus, cart: cartMenus);
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
        yield MenuLoaded(menuResponse: menus, cart: cartMenus);
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
        yield MenuLoaded(menuResponse: menus, cart: cartMenus);
      } catch (e) {
        ErrorState(message: e.toString());
      }
    }
  }
}
