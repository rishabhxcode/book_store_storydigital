part of 'book_save_bloc.dart';

abstract class BookSaveState extends Equatable {
  const BookSaveState();
  @override
  List<Object> get props => [];
}

class BookSaveInitial extends BookSaveState {}

class BookSavedState extends BookSaveState {
  final Book book;
  BookSavedState({required this.book});
  @override
  List<Object> get props => [book];
}

class BookSavingState extends BookSaveState {}

class BookSaveFailedState extends BookSaveState {}
