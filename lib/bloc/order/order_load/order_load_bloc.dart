import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storydigital_task/model/order.dart';
import 'package:storydigital_task/repository/order_repository.dart';

part 'order_load_event.dart';
part 'order_load_state.dart';

class OrderLoadBloc extends Bloc<OrderLoadEvent, OrderLoadState> {
  OrderLoadBloc() : super(OrderLoadInitial());
  OrderRepository orderRepo = OrderRepository();

  @override
  Stream<OrderLoadState> mapEventToState(
    OrderLoadEvent event,
  ) async* {
    try {
      if (event is OrderLoadEvent) {
        var result = await orderRepo.loadOrders();
        yield OrderLoadedState(orders: result);
      }
    } catch (e) {
      print(e);
      yield OrderLoadFailedState();
    }
  }
}
