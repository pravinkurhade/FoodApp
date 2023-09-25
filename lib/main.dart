import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/pages/cart/cart.dart';
import 'package:food_app/pages/home/home.dart';
import 'package:food_app/pages/splash/splash_screen.dart';
import 'bloc/cart/Cart_bloc.dart';
import 'bloc/home/Menu_bloc.dart';
import 'injector_container.dart' as di;

void main() async{
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plateron',
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => BlocProvider<MenuBloc>(
          create: (context) => di.getIt<MenuBloc>(),
          child: const HomeScreen(),
        ),
        CartScreen.routeName: (context) => BlocProvider<CartBloc>(
          create: (context) => di.getIt<CartBloc>(),
          child: const CartScreen(),
        ),
      },
    );
  }
}

