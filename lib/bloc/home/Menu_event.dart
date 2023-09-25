part of 'Menu_bloc.dart';

abstract class MenuEvent {}

class GetMenuEvent extends MenuEvent {
  GetMenuEvent();
}

class AddToCartEvent extends MenuEvent {
  String id;

  AddToCartEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class RemoveFromCartEvent extends MenuEvent {
  String id;

  RemoveFromCartEvent({required this.id});

  @override
  List<Object> get props => [id];
}
