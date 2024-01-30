import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';

class ReuseableTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obsecure;
  final String label;
  final TextEditingController contr;
  final bool readOnly;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final Icon? prefixIcon;

  ReuseableTextField({
    super.key,
    required this.contr,
    required this.label,
    required this.textInputAction,
    required this.keyboardType,
    required this.obsecure,
    this.onChange,
    this.readOnly = false,
    this.inputFormatters,
    this.prefixIcon,

    //
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        controller: contr,
        readOnly: readOnly,
        textInputAction: textInputAction,
        obscureText: obsecure,
        keyboardType: keyboardType,
        onChanged: onChange,
        style: GoogleFonts.openSans(
          fontSize: 15,
        ),
        inputFormatters: inputFormatters,

        // focusNode: focNode,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(),
          ),
          prefixIcon: prefixIcon,
          enabled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.nonActiveTextFieldColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.activeTextFieldColor),
          ),
          labelStyle: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,

          ),
        ),
      ),
    );
  }
}
