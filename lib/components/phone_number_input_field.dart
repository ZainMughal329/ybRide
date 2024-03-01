import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/settings/pages/profile/controller.dart';







Widget PhoneNumberField(CountryCode code, Function changeCountry, TextEditingController phone, bool isFocus, Function onPress, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: InkWell(
      onFocusChange: (value) {
        final con = Get.put(ProfileController());
        con.onFocusChange(value ?? false);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isFocus ? AppColors.activeTextFieldColor : AppColors.nonActiveTextFieldColor,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
                                child: CountryCodeFlagWidget(

                                  width: 34,
                                  alignment: Alignment.center,
                                  countryCode: CountryCode(
                                      name: code.name,
                                      code: code.code,
                                      dialCode: code.dialCode),
                                ),
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
                              color: Theme.of(context).lightTextColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 1,
                    color: Theme.of(context).lightTextColor,
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        controller: phone,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.openSans(
                          fontSize: 15,
                        ),
                        maxLength: 12, // Maximum length including dashes
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          PhoneNumberFormatter(),
                        ],
                        decoration: InputDecoration(
                          // labelText: 'Phone',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          border: InputBorder.none,
                          labelStyle: GoogleFonts.openSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).headingColor
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

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final formattedText = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) {
        formattedText.write('-');
      }
      formattedText.write(text[i]);
    }

    return newValue.copyWith(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
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