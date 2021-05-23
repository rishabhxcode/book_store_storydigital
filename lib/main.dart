import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storydigital_task/bloc/cart/cart_load/cart_load_bloc.dart';
import 'package:storydigital_task/bloc/order/order_load/order_load_bloc.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:storydigital_task/theme.dart';

import 'bloc/cart/cart_bloc.dart';
import 'bloc/order/order_bloc.dart';
import 'ui/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Something went wrong!'),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<CartLoadBloc>(
                  create: (context) => CartLoadBloc(),
                ),
                BlocProvider<OrderLoadBloc>(
                    create: (context) => OrderLoadBloc()),
                BlocProvider<CartBloc>(
                  create: (context) => CartBloc(
                      cartLoadBloc: BlocProvider.of<CartLoadBloc>(context)),
                ),
                BlocProvider<OrderBloc>(
                  create: (context) => OrderBloc(
                      cartBloc: BlocProvider.of<CartBloc>(context),
                      orderLoadBloc: BlocProvider.of<OrderLoadBloc>(context)),
                )
              ],
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Book Store',
                  theme: AppTheme.defaultTheme,
                  home: HomeScreen()));
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
