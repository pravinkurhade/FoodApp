part of 'Cart_bloc.dart';

abstract class CartEvent {}

class GetMenuEvent extends CartEvent {
  GetMenuEvent();
}

class GetCartMenuEvent extends CartEvent {
  Map<String, int> cartMenus;

  GetCartMenuEvent({required this.cartMenus});

  @override
  List<Object> get props => [cartMenus];
}

class AddToCartEvent extends CartEvent {
  String id;

  AddToCartEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class RemoveFromCartEvent extends CartEvent {
  String id;

  RemoveFromCartEvent({required this.id});

  @override
  List<Object> get props => [id];
}
