import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/repository/cart_repository.dart';

import 'cart_load/cart_load_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required this.cartLoadBloc}) : super(CartInitial());
  CartRepository cartRepo = CartRepository();
  final CartLoadBloc cartLoadBloc;
  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    try {
      if (event is AddBookToCartEvent) {
        yield BookAddingToCartState();
        await cartRepo.addToCart(event.book);
        yield BookAddedToCartState(book: event.book);
        cartLoadBloc.add(CartLoadEvent());
      }
      if (event is CartItemDeleteEvent) {
        await cartRepo.deleteCartItem(event.id);
        cartLoadBloc.add(CartLoadEvent());
      }
      if (event is EmptyCartEvent) {
        await cartRepo.emptyCart();
        yield CartEmptiedState();
        cartLoadBloc.add(CartLoadEvent());
      }
    } catch (e) {
      print(e);
    }
  }
}
