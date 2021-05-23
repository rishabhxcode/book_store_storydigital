import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:storydigital_task/model/book.dart';

CollectionReference books = FirebaseFirestore.instance.collection('books');
FirebaseStorage _storage = FirebaseStorage.instance;

class BookSaveRepository {
  Future<String> uploadImage(File file, String name) async {
    try {
      var result = await _storage.ref('/$name.png').putFile(file);
      var url = await result.storage.ref('/$name.png').getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Book> save(Book book) async {
    try {
      var result = await books.add(book.toJson());
      await books.doc('/${result.id}').update({'id': result.id});
      return book;
    } on FirebaseException catch (e) {
    print(e);
      rethrow;
    }
  }
}
