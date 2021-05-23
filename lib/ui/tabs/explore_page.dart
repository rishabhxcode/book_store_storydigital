import 'package:flutter/material.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/repository/books_repository.dart';
import 'package:storydigital_task/ui/widgets/book_item.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  BooksRepository booksRepo = BooksRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
        future: booksRepo.getBooks(),
        builder: (context, snapshot) {
          print(snapshot.connectionState);
          if (snapshot.hasData) {
            var books = snapshot.data ?? [];

            return books.length > 0
                ? ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return BookItem(
                        book: books[index],
                      );
                    },
                  )
                : Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.not_interested_outlined,
                              size: 100, color: Colors.amber),
                          Text(
                            'No books here!\nPlease add one to see',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 30), 
                          )
                        ]),
                  );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
