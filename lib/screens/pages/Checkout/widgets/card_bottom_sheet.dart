import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';

import '../../../../main.dart';

Future CardBottomSheet(
    BuildContext context, bool isCardExist, CheckOutCon controller) {
  if (isCardExist == true) {
    controller.state.cardNumController.text = controller.state.cardNumber.value;
    controller.state.cvvController.text = controller.state.cvvNumber.value;
    controller.state.expiryController.text = controller.state.expNumber.value;
    controller.state.zipController.text = controller.state.zipCode.value;
  }
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Theme.of(context).scaffoldBgClr,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * .03, vertical: mq.height * .03),
            child: Column(children: [
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ReuseableTextField(
                  contr: controller.state.cardNumController,
                  label: 'Card number',
                  prefixIcon: Icon(Icons.credit_card),
                  textInputAction: TextInputAction.next,
                  obsecure: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.symmetric(vertical: 8.0),
                      margin: const EdgeInsets.only(top: 8),
                      child: _expiryField(controller),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.symmetric(vertical: 8.0),
                      margin: const EdgeInsets.only(top: 8),
                      child: ReuseableTextField(
                        contr: controller.state.cvvController,
                        label: 'CVC ',
                        textInputAction: TextInputAction.next,
                        obsecure: false,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only(top: 8),
                child: ReuseableTextField(
                  contr: controller.state.zipController,
                  label: 'Zip code ',
                  textInputAction: TextInputAction.done,
                  obsecure: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 40),

              Obx((){
                return controller.state.cardLoading == false ? RoundButton(
                    title: 'Save',
                    onPress: () {
                      if (isCardExist == true) {
                        controller.saveCreditCardDataToFirestore(
                            controller.state.cardNumController.text.trim().toString(),
                            controller.state.expiryController.text.trim().toString(),
                            controller.state.cvvController.text.trim().toString(),
                            controller.state.zipController.text.trim().toString(),
                            context);
                      } else {
                        if(controller.state.cardNumController.text.isNotEmpty &&
                            controller.state.expiryController.text.isNotEmpty &&
                            controller.state.cvvController.text.isNotEmpty &&
                            controller.state.zipController.text.isNotEmpty
                        ){
                          controller.state.cardNumber.value=controller.state.cardNumController.text.trim().toString();
                          controller.saveCreditCardDataToFirestore(
                              controller.state.cardNumController.text.trim().toString(),
                              controller.state.expiryController.text.trim().toString(),
                              controller.state.cvvController.text.trim().toString(),
                              controller.state.zipController.text.trim().toString(),
                              context);
                        }else{
                          Snackbar.showSnackBar('YB-Ride', 'Enter all details', Icons.error_outline);
                        }
                      }
                    }) : Container(
                  height: 100,
                  width: 100,
                  child: Lottie.asset('assets/lottie/loading2.json'),
                );
              }),
              //RoundButton Code
            ]),
          ),
        );
      });
}

Widget _expiryField(CheckOutCon controller) {
  return Padding(
    padding: EdgeInsets.only(
      left: 20,
    ),
    child: TextFormField(
      controller: controller.state.expiryController,
      style: GoogleFonts.openSans(
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: 'MM/YY',
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: AppColors.nonActiveTextFieldColor),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(),
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
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(5),
        _ExpiryDateInputFormatter(),
      ],
      onChanged: (value) {
        // controller.state.expiryDateVal.value = value;
      },
    ),
  );
}

class _ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 2) {
      if (oldValue.text.length < newValue.text.length) {
        text += '/';
      }
    }

    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
