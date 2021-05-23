import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storydigital_task/bloc/cart/cart_bloc.dart';
import 'package:storydigital_task/bloc/cart/cart_load/cart_load_bloc.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/ui/book_detail_screen.dart';

class BookItem extends StatelessWidget {
  final Book book;

  const BookItem({Key? key, required this.book}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookDetailScreen(book: book)));
        },
        child: Row(
          children: [
            Container(
              width: 130,
              margin: EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        book.image!,
                      )),
                  color: Colors.lime,
                  borderRadius: BorderRadius.circular(6)),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title ?? '',
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      book.author ?? '',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '₹ ${book.price}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Spacer(),
                        AddToCartButton(
                          book: book,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AddToCartButton extends StatefulWidget {
  final double? iconSize;
  final double? textSize;
  final Book book;

  const AddToCartButton(
      {Key? key, this.iconSize, this.textSize, required this.book})
      : super(key: key);
  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isInCart = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartLoadBloc, CartLoadState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          var books = state.books;
          var idList = List.generate(
                  state.books.length,
                  (index) =>
                      '${books[index].title}${books[index].author}${books[index].price}')
              .toList();
          _isInCart = idList.contains(
              '${widget.book.title}${widget.book.author}${widget.book.price}');
          return _isInCart
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check, color: Colors.green),
                      Text(
                        'Added',
                        style: TextStyle(color: Colors.white, fontSize: 18),  
                      )
                    ],
                  ),
                )
              : AddToCart(
                  book: widget.book,
                  iconSize: widget.iconSize,
                  textSize: widget.textSize,
                );
        }
        return AddToCart(
          book: widget.book,
          iconSize: widget.iconSize,
          textSize: widget.textSize,
        );
      },
    );
  }
}

class AddToCart extends StatelessWidget {
  final double? iconSize;
  final double? textSize;
  final Book book;

  const AddToCart({Key? key, this.iconSize, this.textSize, required this.book})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<CartBloc>(context).add(AddBookToCartEvent(book: book));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_shopping_cart_rounded,
              color: Colors.white,
              size: iconSize ?? 18,
            ),
            Text(
              'ADD TO CART',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: textSize ?? 14,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
