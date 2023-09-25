
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/models/menu.dart';
import '../../bloc/cart/Cart_bloc.dart';
import '../../utlis/common/navigation.dart';

class CartScreen extends StatefulWidget {
  static String routeName = 'cart_screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Menu> menus = [];
  late Map<String, int> cartMenus;
  var total = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
        var item = ModalRoute.of(context)!.settings.arguments as Map<String, int>;
        cartMenus = item;
        BlocProvider.of<CartBloc>(context).add(GetCartMenuEvent(cartMenus: cartMenus));
        if (kDebugMode) {
          print(item.length);
        }
    });
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
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is CartMenuLoaded) {
              if (kDebugMode) {
                 print(state.menuResponse.length);
                 print(state.cart);
                 print(state.total);
              }
              menus = state.menuResponse;
              cartMenus = state.cart;
              total = state.total;
            }
          },
          builder: (context, state) {
            if (state is CartMenuLoaded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigation.back(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      'images/backbutton.png',
                                      fit: BoxFit.fill,
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'My Cart',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ),
                              ),
                            ],
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
                                                                  BlocProvider.of<CartBloc>(context).add(AddToCartEvent(id: item.$oid));
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
                                                                        BlocProvider.of<CartBloc>(context).add(RemoveFromCartEvent(id: item.$oid));
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
                                                                        BlocProvider.of<CartBloc>(context).add(AddToCartEvent(id: item.$oid));
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
                      Container(
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
                                      icon: const Icon(Icons.attach_money,  color: Colors.green,size:  20.0),
                                      onPressed: () {

                                      },
                                    )
                                ),
                                Text(total.toString()),
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
                                child: const Text('Pay Now'),
                              ),
                            )
                          ],
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