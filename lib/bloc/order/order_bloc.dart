import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storydigital_task/bloc/cart/cart_bloc.dart';
import 'package:storydigital_task/bloc/order/order_load/order_load_bloc.dart';
import 'package:storydigital_task/model/order.dart';
import 'package:storydigital_task/repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({this.cartBloc, this.orderLoadBloc}) : super(OrderInitial());
  OrderRepository orderRepo = OrderRepository();
  final CartBloc? cartBloc;
  final OrderLoadBloc? orderLoadBloc;

  @override
  Stream<OrderState> mapEventToState(
    OrderEvent event,
  ) async* {
    try {
      if (event is PlaceOrderEvent) {
        yield PlacingOrderState();
        await orderRepo.placeOrder(event.order);
        cartBloc!.add(EmptyCartEvent());
        yield PlacedOrderState();
      }
      if (event is OrderDeleteEvent) {
        await orderRepo.deleteOrder(event.id);
        yield OrderDeletedState();
        orderLoadBloc!.add(OrderLoadEvent());
      }
    } catch (e) {
      print(e);
    }
  }
}
