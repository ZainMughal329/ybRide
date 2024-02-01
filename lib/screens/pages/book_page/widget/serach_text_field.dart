import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';

Widget SearchTextField(BuildContext context , BookViewController cont){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: TextFormField(
      controller: cont.state.locationSearchController,
      readOnly: false,
      textInputAction: TextInputAction.search,
      obscureText: false,
      keyboardType: TextInputType.streetAddress,
      onChanged: (value) {},
      style: GoogleFonts.openSans(
        fontSize: 15,
      ),
      onTapOutside: (value){
        FocusScope.of(context).unfocus();

      },

      // focusNode: focNode,
      decoration: InputDecoration(
        labelText: 'Type an address and city',
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(),
        ),
        prefixIcon: Icon(
          CupertinoIcons.search,
          size: 26,
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          BorderSide(color: Theme.of(context).headingColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
          BorderSide(color: AppColors.buttonColor),
        ),
        labelStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}