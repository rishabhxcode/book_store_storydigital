import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final num total;
  final num totalItems;
  final String? id;

  Order({required this.total, required this.totalItems, this.id});
  static Order fromJson(Map<String, dynamic> json) {
    return Order(
        total: json['total'], totalItems: json['totalItems'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'total': this.total, 'totalItems': this.totalItems, 'id': this.id};
  }

  @override
  List<Object?> get props => [total, totalItems, id];
}
