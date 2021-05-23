import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storydigital_task/bloc/book_save/book_save_bloc.dart';
import 'package:storydigital_task/model/book.dart';
import 'package:storydigital_task/repository/book_save_repository.dart';
import 'package:storydigital_task/ui/widgets/default_app_button.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookSaveBloc>(
      create: (context) => BookSaveBloc(),
      child: AddProductWidget(),
    );
  }
}

class AddProductWidget extends StatefulWidget {
  const AddProductWidget({Key? key}) : super(key: key);

  @override
  _AddProductWidgetState createState() => _AddProductWidgetState();
}

class _AddProductWidgetState extends State<AddProductWidget> {
  Map<String, dynamic> newBook = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  File? _image;
  var successSnackBar = SnackBar(
      content: Container(
    child: Row(
      children: [
        Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        Text(' Saved Successfully')
      ],
    ),
  ));

  bool isValidate() {
    return titleController.text.isNotEmpty &&
        authorController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        _image != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8),
              child: ImagePickerWidget(
                onChange: (val) {
                  setState(() {
                    _image = val;
                  });
                },
              ),
            ),
            AppTextField(
              label: 'Title*',
              controller: titleController,
              onChange: (val) {
                setState(() {
                  newBook['title'] = val;
                });
              },
            ),
            AppTextField(
              label: 'Author*',
              prefixIcon: Icon(Icons.person),
              controller: authorController,
              onChange: (val) {
                setState(() {
                  newBook['author'] = val;
                });
              },
            ),
            AppTextField(
              label: 'Description',
              maxLines: 3,
              controller: descriptionController,
              onChange: (val) {
                setState(() {
                  newBook['description'] = val;
                });
              },
            ),
            AppTextField(
              label: 'Price*',
              textInputType: TextInputType.number,
              prefixIcon: Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: Text(
                    '₹',
                    style: TextStyle(fontSize: 18),
                  )),
              controller: priceController,
              onChange: (val) {
                setState(() {
                  newBook['price'] = val;
                });
              },
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                height: 50,
                child: BlocConsumer<BookSaveBloc, BookSaveState>(
                    builder: (context, state) {
                  if (state is BookSavingState) { 
                    return DefaultAppButton(
                      onPressed: () {},
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    );
                  }
                  return DefaultAppButton(
                      child: Text(
                        'SAVE BOOK',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      onPressed: isValidate()
                          ? () {
                              print(newBook);
                              BlocProvider.of<BookSaveBloc>(context).add(
                                  BookSaveEvent(
                                      book: Book.fromJson(newBook),
                                      image: _image!));
                            }
                          : null);
                }, listener: (context, state) {
                  if (state is BookSavedState) {
                    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                    titleController.text = '';
                    authorController.text = '';
                    descriptionController.text = '';
                    priceController.text = '';
                    _image = null;
                  }
                }))
          ])),
    );
  }
}

class AppTextField extends StatelessWidget {
  final String? label;
  final int? maxLines;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final Function(String) onChange;
  final TextInputType? textInputType;

  final _defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(
    width: 0.5,
  ));

  AppTextField({
    Key? key,
    this.label,
    this.maxLines,
    this.prefixIcon,
    required this.controller,
    required this.onChange,
    this.textInputType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: textInputType ?? TextInputType.text,
        maxLines: maxLines,
        minLines: maxLines,
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          border: _defaultBorder,
          enabledBorder: _defaultBorder,
          focusedBorder: _defaultBorder,
        ),
      ),
    );
  }
}

class ImagePickerWidget extends StatefulWidget {
  final Function(File) onChange;
  const ImagePickerWidget({Key? key, required this.onChange}) : super(key: key);
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _image;
  final picker = ImagePicker();
  BookSaveRepository bookSaveRepo = BookSaveRepository();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onChange(_image!);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookSaveBloc, BookSaveState>(
      listener: (context, state) {
        if (state is BookSavedState) {
          setState(() {
            _image = null;
          });
        }
      },
      child: InkWell(
        onTap: getImage,
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(4)),
          child: _image != null
              ? Image.file(
                  _image!,
                  fit: BoxFit.cover,
                )
              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Icon(
                    Icons.add_a_photo_outlined,
                    color: Colors.amber,
                    size: 30,
                  ),
                  Text(
                    'Add Image\n(required)',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  )
                ]),
        ),
      ),
    );
  }
}
