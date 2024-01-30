import 'package:flutter/material.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/main.dart';

import 'heading_text_widget.dart';

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: HeadingTextWidget(title:
      question,
          textColor: Theme.of(context).headingColor,
          fontWeight: FontWeight.bold),

      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SubHeadingTextWidget(title: answer,textColor: Theme.of(context).lightTextColor,),
        ),
      ],
    );
  }
}
