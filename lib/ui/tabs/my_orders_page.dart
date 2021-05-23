import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storydigital_task/bloc/order/order_bloc.dart';
import 'package:storydigital_task/bloc/order/order_load/order_load_bloc.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  void initState() {
    BlocProvider.of<OrderLoadBloc>(context).add(OrderLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderLoadBloc, OrderLoadState>(
        builder: (context, state) {
      print(state);
      if (state is OrderLoadedState) {
        return state.orders.length > 0
            ? ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 112,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.amber,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text('ORDER',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                            const Spacer(),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              iconSize: 20,
                              icon: Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                BlocProvider.of<OrderBloc>(context).add(
                                    OrderDeleteEvent(
                                        id: state.orders[index].id!));
                              },
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Total books Ordered: ',
                              style: TextStyle(
                                  color: Colors.amber[800], fontSize: 16),
                            ),
                            Text(
                              state.orders[index].totalItems.toString(),
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Order Amount: ',
                              style: TextStyle(
                                  color: Colors.amber[800], fontSize: 16),
                            ),
                            Text(
                              '₹ ${state.orders[index].total}',
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                })
            : Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Icon(
                      Icons.no_sim_outlined,
                      color: Colors.amber,
                      size: 100,
                    ),
                    Text(
                      'No Orders present',
                      style: TextStyle(fontSize: 30, color: Colors.grey),
                    )
                  ],
                ),
              );
      }
      return Center(child: CircularProgressIndicator());
    });
  }
}
