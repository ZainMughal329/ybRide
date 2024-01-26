import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingTextWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextDecoration decoration;
  final Color decorationColor;
  final FontStyle fontStyle;
  final TextAlign? textAlign;

  const HeadingTextWidget(
      {super.key,
        required this.title,
        this.textColor = Colors.black,
        this.fontSize = 18,
        this.fontWeight = FontWeight.bold,
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
        height: 1.0

      ),
    );
  }
}
