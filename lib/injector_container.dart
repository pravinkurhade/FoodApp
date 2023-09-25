import 'package:get_it/get_it.dart';

import 'bloc/cart/Cart_bloc.dart';
import 'bloc/home/Menu_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => MenuBloc());
  getIt.registerFactory(() => CartBloc());
}
