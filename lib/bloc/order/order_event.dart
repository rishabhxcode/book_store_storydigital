part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrderEvent extends OrderEvent {
  final Order order;

  PlaceOrderEvent({required this.order});
  @override
  List<Object> get props => [order];
}

class OrderDeleteEvent extends OrderEvent {
  final String id;

  OrderDeleteEvent({required this.id});
  @override
  List<Object> get props => [id];
}
