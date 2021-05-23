import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storydigital_task/bloc/cart/cart_load/cart_load_bloc.dart';
import 'package:storydigital_task/ui/tabs/add_product_page.dart';
import 'package:storydigital_task/ui/tabs/explore_page.dart';
import 'package:storydigital_task/ui/tabs/my_orders_page.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> appBarTitles = ['Explore', 'My Orders', 'Add Product'];
  int _currentTab = 0;
  late List<Widget> tabs;
  @override
  void initState() {
    tabs = [ExplorePage(), MyOrdersPage(), AddProductPage()];
    BlocProvider.of<CartLoadBloc>(context).add(CartLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitles[_currentTab],
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            CartIcon(),
          ],
        ),
        body: tabs[_currentTab],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentTab,
            onTap: (index) {
              setState(() {
                _currentTab = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: 'Explore'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.receipt), label: 'My Orders'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_box), label: 'Add Product'),
            ]));
  }
}

class CartIcon extends StatefulWidget {
  @override
  _CartIconState createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartScreen()));
      },
      child: Container(
        height: 56,
        width: 56,
        child: Stack(alignment: Alignment.center, children: [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
            size: 28,
          ),
          Positioned(
            right: 4,
            top: 3,
            child: BlocBuilder<CartLoadBloc, CartLoadState>(
              builder: (context, state) {
                if (state is CartLoadedState) {
                  return state.books.length > 0
                      ? Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                          ),
                          child: Text(
                            '${state.books.length}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ))
                      : Container();
                }
                return Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
