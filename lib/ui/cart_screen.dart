import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storydigital_task/bloc/cart/cart_bloc.dart';
import 'package:storydigital_task/bloc/cart/cart_load/cart_load_bloc.dart';
import 'package:storydigital_task/bloc/order/order_bloc.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/model/order.dart';
import 'package:storydigital_task/repository/cart_repository.dart';
import 'package:storydigital_task/ui/widgets/default_app_button.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartRepository cartRepo = CartRepository();
  num total = 0;
  num totalItems = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<CartLoadBloc, CartLoadState>(builder: (context, state) {
        if (state is CartLoadedState) {
          return state.books.length > 0
              ? ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    return state.books.length - 1 == index
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 120),
                            child: CartItem(
                              book: state.books[index],
                            ),
                          )
                        : CartItem(
                            book: state.books[index],
                          );
                  })
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart_outlined,
                        size: 100,
                        color: Colors.amber,
                      ),
                      Text(
                        'No items in Cart, please add items to place order',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                );
        }
        return Container();
      }),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text(
                  'TOTAL : ',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                BlocBuilder<CartLoadBloc, CartLoadState>(
                  builder: (context, state) {
                    if (state is CartLoadedState) {
                      total = 0;
                      totalItems = 0;
                      for (var book in state.books) {
                        total += book.price!;
                      }
                      totalItems = state.books.length;
                    }
                    return Text(
                      '₹ $total',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    );
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is PlacingOrderState) {
                return Container(
                    width: double.infinity,
                    height: 56,
                    child: DefaultAppButton(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                      onPressed: () {},
                    ));
              }
              return Container(
                  width: double.infinity,
                  height: 56,
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<CartLoadBloc, CartLoadState>(
                        listener: (context, state) {
                          if (state is CartLoadedState) {
                            setState(() {});
                          }
                        },
                      ),
                      BlocListener<CartBloc, CartState>(
                        listener: (context, state) {
                          print(state);
                          if (state is CartEmptiedState) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                  Text(' Order Placed Successfully')
                                ],
                              ),
                            ));
                          }
                        },
                      ),
                    ],
                    child: DefaultAppButton(
                      child: Text(
                        "PLACE ORDER",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: totalItems > 0
                          ? () {
                              BlocProvider.of<OrderBloc>(context).add(
                                  PlaceOrderEvent(
                                      order: Order.fromJson({
                                'total': total,
                                'totalItems': totalItems
                              })));
                            }
                          : null,
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final Book book;

  const CartItem({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 110,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(book.image!)))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title!,
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  book.author!,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '₹ ${book.price}',
                      style: TextStyle(fontSize: 20),
                    ),
                    const Spacer(),
                    TextButton(
                      child: Text('REMOVE',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 12)),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context)
                            .add(CartItemDeleteEvent(id: book.id!));
                      }, 
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
