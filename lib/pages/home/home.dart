import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/menu.dart';
import 'package:food_app/pages/cart/cart.dart';
import '../../bloc/home/Menu_bloc.dart';
import '../../utlis/common/navigation.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Menu> menus = [];
  late Map<String, int> cartMenus = HashMap();

  @override
  void initState() {
    BlocProvider.of<MenuBloc>(context).add(GetMenuEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocConsumer<MenuBloc, MenuState>(
          listener: (context, state) {
            if (state is MenuLoaded) {
              if (kDebugMode) {
                print(state.menuResponse.length);
                print(state.cart);
              }
              menus = state.menuResponse;
              cartMenus = state.cart;
            }
          },
          builder: (context, state) {
            if (state is MenuLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Plateron',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 35,
                                alignment:
                                    Alignment.centerLeft, // This is needed
                                child: Image.asset(
                                  'images/user.png',
                                  fit: BoxFit.contain,
                                  width: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: menus.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = menus[index];
                              var count = 0;
                              var cartItem = cartMenus.containsKey(item.$oid);
                              if(cartItem){
                                count = cartMenus[item.$oid]!;
                              }
                              return GestureDetector(
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image.network(
                                              item.image,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.name,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  item.description,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                    color: Colors.black.withOpacity(0.5),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\$ ${item.price}",
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w900,
                                                      ),
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.white,
                                                        boxShadow: const [
                                                          BoxShadow(color: Colors.green, spreadRadius: 1),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Visibility(
                                                            visible: !cartItem,
                                                            child:  Padding(
                                                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                                              child: GestureDetector(
                                                                onTap: () {
                                                                  BlocProvider.of<MenuBloc>(context).add(AddToCartEvent(id: item.$oid));
                                                                  if (kDebugMode) {
                                                                    print("plus");
                                                                  }
                                                                },
                                                                child: const Row(
                                                                  children: [
                                                                    Text("ADD",style: TextStyle(
                                                                      color: Colors.green,
                                                                    ),)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible: cartItem,
                                                            child: Row(
                                                              children: [
                                                                SizedBox(
                                                                    height: 30.0,
                                                                    width: 30.0,
                                                                    child: IconButton(
                                                                      padding: const EdgeInsets.all(0.0),
                                                                      icon: const Icon(Icons.remove, color: Colors.green, size: 20.0),
                                                                      onPressed: () {
                                                                        BlocProvider.of<MenuBloc>(context).add(RemoveFromCartEvent(id: item.$oid));
                                                                        if (kDebugMode) {
                                                                          print("minus");
                                                                        } },
                                                                    )
                                                                ),
                                                                 Text(
                                                                  count.toString(),
                                                                  style: const TextStyle(
                                                                    fontWeight: FontWeight.w900,
                                                                    fontSize: 20,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 30.0,
                                                                    width: 30.0,
                                                                    child: IconButton(
                                                                      padding: const EdgeInsets.all(0.0),
                                                                      icon: const Icon(Icons.add,  color: Colors.green,size: 20.0),
                                                                      onPressed: () {
                                                                        BlocProvider.of<MenuBloc>(context).add(AddToCartEvent(id: item.$oid));
                                                                        if (kDebugMode) {
                                                                          print("plus");
                                                                        }
                                                                      },
                                                                    )
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Visibility(
                        visible: cartMenus.isNotEmpty,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                      height: 30.0,
                                      width: 30.0,
                                      child: IconButton(
                                        padding: const EdgeInsets.all(0.0),
                                        icon: const Icon(Icons.shopping_cart,  color: Colors.green,size:  20.0),
                                        onPressed: () {

                                        },
                                      )
                                  ),
                                  Text("${cartMenus.length} Item"),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (kDebugMode) {
                                      print(cartMenus);
                                    }
                                    Navigation.intentWithData(context, CartScreen.routeName, cartMenus);
                                  },
                                  style: ElevatedButton.styleFrom(primary: Colors.green,shape: const StadiumBorder()),
                                  child: const Text('Place Order'),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: Text('Loading...',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            );
          },
        ),
      ),
    );
  }
}