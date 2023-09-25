part of 'Menu_bloc.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class LoadingState extends MenuState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends MenuState {
  final int? status;
  final String? message;

  ErrorState({this.status, this.message});

  @override
  List<Object> get props => [];
}

class MenuLoaded extends MenuState {
  final List<Menu> menuResponse;
  final Map<String, int> cart;
  MenuLoaded({required this.menuResponse,required this.cart});

  @override
  List<Object?> get props => [menuResponse,cart];
}
