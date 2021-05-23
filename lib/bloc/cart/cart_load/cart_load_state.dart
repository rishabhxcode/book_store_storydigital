part of 'cart_load_bloc.dart';

abstract class CartLoadState extends Equatable {
  const CartLoadState();

  @override
  List<Object> get props => [];
}

class CartLoadInitial extends CartLoadState {}

class CartLoadingState extends CartLoadState {}

class CartLoadedState extends CartLoadState {
  final List<Book> books;
  CartLoadedState({required this.books});
  @override
  List<Object> get props => [books];
}

class CartLoadFailedState extends CartLoadState {}
