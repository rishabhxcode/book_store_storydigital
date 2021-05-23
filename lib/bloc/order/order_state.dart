part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class PlacingOrderState extends OrderState {}

class PlacedOrderState extends OrderState {}

class OrderDeletedState extends OrderState {}
