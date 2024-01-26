import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';

class BookNowView extends GetView<BookViewController> {
  const BookNowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(),
        Scaffold(
          body: SafeArea(
            child: Column(
              children: [],
            ),
          ),
        ),
      ],
    );
  }
}
