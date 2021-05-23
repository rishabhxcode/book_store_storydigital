import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/repository/book_save_repository.dart';

part 'book_save_event.dart';
part 'book_save_state.dart';

class BookSaveBloc extends Bloc<BookSaveEvent, BookSaveState> {
  BookSaveBloc() : super(BookSaveInitial());
  BookSaveRepository saveRepo = BookSaveRepository();

  @override
  Stream<BookSaveState> mapEventToState(
    BookSaveEvent event,
  ) async* {
    try {
      if (event is BookSaveEvent) {
        yield BookSavingState();
        var image =
            await saveRepo.uploadImage(event.image, event.book.title!.trim());
        Book newBook = Book.setImage(event.book, image);
        var result = await saveRepo.save(newBook);
        yield BookSavedState(book: result);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
