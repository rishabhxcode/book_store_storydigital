part of 'book_save_bloc.dart';

class BookSaveEvent extends Equatable {
  final File image;
  final Book book;
  const BookSaveEvent({required this.image, required this.book});
  @override
  List<Object> get props => [image, book];
}
