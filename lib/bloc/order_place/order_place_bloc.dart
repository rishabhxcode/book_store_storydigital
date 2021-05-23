import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_place_event.dart';
part 'order_place_state.dart';

class OrderPlaceBloc extends Bloc<OrderPlaceEvent, OrderPlaceState> {
  OrderPlaceBloc() : super(OrderPlaceInitial());

  @override
  Stream<OrderPlaceState> mapEventToState(
    OrderPlaceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
