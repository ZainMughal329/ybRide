import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';

import '../main.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final Color color, textcolor, borderColor;
  final VoidCallback onPress;
  final bool loading;

  const RoundButton(
      {super.key,
        required this.title,
        required this.onPress,
        this.textcolor = Colors.white,
        this.borderColor = Colors.white,
        this.color = Colors.green,
        this.loading = false});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10 , horizontal: mq.width * .04),
          child: InkWell(
            child: Container(
              height: mq.height * .06,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.buttonColor,
              ),
              child: loading
                  ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                  : Center(
                child: Text(
                  title,
                  style: GoogleFonts.openSans(color: AppColors.buttonTextColor, fontSize: 14,fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
