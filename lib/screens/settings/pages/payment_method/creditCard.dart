import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/controller.dart';
import '../../../../components/custom_Appbar.dart';
import '../../../../helper/app_colors.dart';
import '../../../../main.dart';

class CreditCardScreen extends GetView<PaymentCon> {
  bool isLightTheme = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CreditCardScreen({super.key});
  final controller = Get.put<PaymentCon>(PaymentCon());

  Widget _expiryField() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
      ),
      child: TextFormField(
        controller: controller.state.expiryDate,
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
          controller.state.expiryDateVal.value = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.fetchCardDetails();

    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(
          centerTitle: 'Saved payment methods',
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios_new,
          leadingPress: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .03, vertical: mq.height * .03),
        child: Column(children: [
          SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: ReuseableTextField(
              contr: controller.state.cardNumber,
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
                  child: _expiryField(),
                ),
              ),
              Expanded(
                child: Container(
                  // padding: const EdgeInsets.symmetric(vertical: 8.0),
                  margin: const EdgeInsets.only(top: 8),
                  child: ReuseableTextField(
                    contr: controller.state.cvv,
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
              contr: controller.state.zipCode,
              label: 'Zip code ',
              textInputAction: TextInputAction.done,
              obsecure: false,
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 40),
          Obx(() {
            return controller.state.loading.value == true
                ? Container(
                    height: mq.height * .06,
                    width: double.infinity,
                    child: Lottie.asset('assets/lottie/loading2.json'),
                  )
                : RoundButton(
                    title: 'Save',
                    onPress: () {
                      if (controller.state.cardNumber.text.trim().isNotEmpty &&
                          controller.state.expiryDate.text.trim().isNotEmpty &&
                          controller.state.cvv.text.trim().isNotEmpty &&
                          controller.state.zipCode.text.trim().isNotEmpty ) {
                        controller.saveCreditCardDataToFirestore(
                            controller.state.documentId,
                            controller.state.cardNumber.text.trim().toString(),
                            controller.state.expiryDate.text.trim().toString(),
                            controller.state.zipCode.text.trim().toString(),
                            controller.state.cvv.text.trim().toString(),
                            context);
                      } else {
                        Snackbar.showSnackBar("YB-Ride", "Enter all fields",
                            Icons.error_outline_outlined);
                      }
                    },
                  );
          })
        ]),
      ),
    );
  }
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
