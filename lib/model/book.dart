import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String? id;
  final String? title;
  final String? author;
  final String? image;
  final String? description;
  final num? price;

  Book(
      {this.id,
      this.title,
      this.author,
      this.image,
      this.description,
      this.price});

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'],
        author: json['author'],
        description: json['description'],
        image: json['image'],
        price: num.tryParse(json['price'].toString()),
        title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'id': this.id,
      'image': this.image,
      'price': this.price,
      'description': this.description,
      'author': this.author
    };
  }

  static Book setImage(Book book, String image) {
    Book newBook = book;
    var json = newBook.toJson();
    json['image'] = image;
    return Book.fromJson(json);
  }

  @override
  List<Object?> get props => [id, author, image, description, price, title];
}
