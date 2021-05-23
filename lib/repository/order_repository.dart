import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storydigital_task/model/order.dart';

CollectionReference orders = FirebaseFirestore.instance.collection('orders');

class OrderRepository {
  Future<List<Order>> loadOrders() async {
    try {
      var response = await orders.get();
      List<Order> list = [];
      response.docs.forEach((element) {
        Map<String, dynamic> orderMap = element.data() as Map<String, dynamic>;
        list.add(Order.fromJson(orderMap));
        print(list);
      });
      return list;
    } on FirebaseException catch (e) {
      print(e);
    }
    throw Exception('something Went wrong');
  }

  Future<void> placeOrder(Order order) async {
    try {
      var result = await orders.add(order.toJson());
      await orders.doc('/${result.id}').update({'id': result.id});
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> deleteOrder(String id) async {
    try {
      await orders.doc('/$id').delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
