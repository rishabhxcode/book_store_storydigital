part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddBookToCartEvent extends CartEvent {
  final Book book;
  AddBookToCartEvent({required this.book});
  @override
  List<Object> get props => [book];
}

class CartDeleteEvent extends CartEvent {}

class CartItemDeleteEvent extends CartEvent {
  final String id;

  CartItemDeleteEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class EmptyCartEvent extends CartEvent {}
