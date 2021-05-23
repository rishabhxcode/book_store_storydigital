import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storydigital_task/model/book.dart';

CollectionReference cart = FirebaseFirestore.instance.collection('cart');

class CartRepository {
  Future<void> addToCart(Book book) async {
    try {
      await cart.add(book.toJson());
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> deleteCartItem(String id) async {
    try {
      await cart.doc('/$id').delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<List<Book>> getCart() async {
    try {
      var response = await cart.get();
      List<Book> list = [];
      response.docs.forEach((element) {
        Map<String, dynamic> bookMap = element.data() as Map<String, dynamic>;
        bookMap['id'] = element.id;
        list.add(Book.fromJson(bookMap));
      });
      return list;
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> emptyCart() async {
    try {
      QuerySnapshot result = await cart.get();
      List<DocumentSnapshot> cartList = result.docs;
      cartList.forEach((element) async {
        await element.reference.delete();
      });
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
