import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/repository/cart_repository.dart';

part 'cart_load_event.dart';
part 'cart_load_state.dart';

class CartLoadBloc extends Bloc<CartLoadEvent, CartLoadState> {
  CartLoadBloc() : super(CartLoadInitial());

  CartRepository cartRepo = CartRepository();

  @override
  Stream<CartLoadState> mapEventToState(
    CartLoadEvent event,
  ) async* {
    if (event is CartLoadEvent) {
      try {
        var result = await cartRepo.getCart();
        yield CartLoadedState(books: result); 
      } catch (e) {
        print(e);
      }
    }
  }
}
