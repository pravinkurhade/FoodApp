part of 'Cart_bloc.dart';

@immutable
abstract class CartState {}

class MenuInitial extends CartState {}

class LoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends CartState {
  final int? status;
  final String? message;

  ErrorState({this.status, this.message});

  @override
  List<Object> get props => [];
}

class CartMenuLoaded extends CartState {
  final List<Menu> menuResponse;
  final Map<String, int> cart;
  final int total;
  CartMenuLoaded({required this.menuResponse,required this.cart,required this.total});

  @override
  List<Object?> get props => [menuResponse,cart,total];
}
