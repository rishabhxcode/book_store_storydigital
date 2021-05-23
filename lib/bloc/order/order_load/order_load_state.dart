part of 'order_load_bloc.dart';

abstract class OrderLoadState extends Equatable {
  const OrderLoadState();

  @override
  List<Object> get props => [];
}

class OrderLoadInitial extends OrderLoadState {}

class OrderLoadingState extends OrderLoadState {}

class OrderLoadedState extends OrderLoadState {
  final List<Order> orders;

  OrderLoadedState({required this.orders});
  @override
  List<Object> get props => [orders];
}

class OrderLoadFailedState extends OrderLoadState {}
