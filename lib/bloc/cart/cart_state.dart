part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartSavingState extends CartState {}

class CartSavedstate extends CartState {}

class BookAddedToCartState extends CartState {
  final Book book;

  BookAddedToCartState({required this.book});
  @override
  List<Object> get props => [book];
}

class BookAddingToCartState extends CartState {}

class CartEmptiedState extends CartState {}
