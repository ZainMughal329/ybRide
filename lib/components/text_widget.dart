import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubHeadingTextWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final Color decorationColor;
  final FontStyle fontStyle;
  final TextAlign? textAlign;

  const SubHeadingTextWidget(
      {super.key,
        required this.title,
        this.textColor = Colors.black54,
        this.fontSize = 16,
        this.fontWeight = FontWeight.normal,
        this.decoration = TextDecoration.none,
        this.decorationColor = Colors.black,
        this.fontStyle = FontStyle.normal,
        this.textAlign,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: GoogleFonts.montserrat(
        decoration: decoration,
        decorationColor: decorationColor,
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,

      ),
    );
  }
}
