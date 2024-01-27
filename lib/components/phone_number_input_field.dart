import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';



Widget PhoneNumberField(CountryCode code, Function changeCountry,TextEditingController phone,bool isFocus , VoidCallback onPress) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              // color: AppColors.activeTextFieldColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isFocus ? AppColors.activeTextFieldColor : AppColors.nonActiveTextFieldColor,
              )

            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: GestureDetector(
                        onTap: () => changeCountry(),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                child: code.flagImage(),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextWidget(
                              text: code.dialCode.toString(),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.black.withOpacity(0.4),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 1,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        onTap: onPress,
                        controller: phone,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                        ),

                        // focusNode: focNode,
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          border: InputBorder.none,
                          labelStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget TextWidget({
  required String text,
  double fontSize = 12,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
  );
}