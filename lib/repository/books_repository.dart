import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storydigital_task/model/book.dart';

CollectionReference books = FirebaseFirestore.instance.collection('books');

class BooksRepository {
  Future<List<Book>> getBooks() async {
    try {
      var response = await books.get();
      List<Book> list = [];
      response.docs.forEach((element) {
        Map<String, dynamic> bookMap = element.data() as Map<String, dynamic>;
        bookMap['id'] = element.id;
        list.add(Book.fromJson(bookMap));
      });
      return list;
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }
}
