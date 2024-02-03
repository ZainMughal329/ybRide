


import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:credit_card_type_detector/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/reuseable_button.dart';
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

  Widget _expiryField () {
    return Padding(
      padding: EdgeInsets.only(left: 20,),
      child: TextFormField(
        controller: TextEditingController(text: controller.state.expiryDateVal.value),
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
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    final controller = Get.put<PaymentCon>(PaymentCon());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: CustomAppBarWidget(
          centerTitle: 'Saved payment methods',
          isLeading: true,
          leadingIcon: Icons.arrow_back_ios_new,
          leadingPress: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .03, vertical: mq.height * .03),
        child: Column(
            children: [
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
                      margin: const EdgeInsets.only( top: 8),
                      child: _expiryField(),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.symmetric(vertical: 8.0),
                      margin: const EdgeInsets.only( top: 8),
                      child:ReuseableTextField(
                        contr: controller.state.cvc,
                        label: 'CVC ',
                        textInputAction: TextInputAction.next,
                        obsecure: false,
                        keyboardType: TextInputType.number,
                      ) ,
                    ),
                  ),
                ],
              ),
              Container(
                // padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: const EdgeInsets.only( top: 8),
                child:ReuseableTextField(
                  contr: controller.state.zipCode,
                  label: 'Zip code ',
                  textInputAction: TextInputAction.done,
                  obsecure: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: 40),
              Obx((){
                return controller.state.loading.value == true ? Container(
                  height: mq.height * .06,
                  width: double.infinity,
                  child: Lottie.asset('assets/lottie/loading2.json'),
                ) : RoundButton(title: 'Save', onPress: (){
                  String visaStr = '4647720067791032';

                  var types = detectCCType(visaStr);

                  assert(types.contains(CreditCardType.visa()));
                  print(types.contains(CreditCardType.visa()));
                  print(types.contains(CreditCardType.mastercard()));
                  print(types.contains(CreditCardType.americanExpress()));

                  controller.saveCreditCardDataToFirestore(
                    controller.state.documentId,
                    controller.state.cardNumber.text.trim(),
                    controller.state.expiryDate.text.trim(),
                    controller.state.zipCode.text.trim(),
                    controller.state.cvc.text.trim(),
                  );

                },);
              })
            ]
        ),
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


// class ExpiryDateInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     final text = newValue.text;
//
//     if (text.length == 3 && !text.contains('/')) {
//       return TextEditingValue(
//         text: '${text.substring(0, 2)}/${text.substring(2)}',
//         selection: TextSelection.collapsed(offset: 3),
//       );
//     } else if (text.length == 4) {
//       return TextEditingValue(
//         text: '${text.substring(0, 2)}/${text.substring(2, 4)}',
//         selection: TextSelection.collapsed(offset: 4),
//       );
//     }
//
//     return newValue;
//   }
// }



// class ExpiryDateInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//       TextEditingValue oldValue,
//       TextEditingValue newValue,
//       ) {
//     // Handle backspace
//     if (newValue.text.length < oldValue.text.length) {
//       return newValue;
//     }
//
//     var text = newValue.text;
//
//     if (text.length == 2) {
//       text += '/';
//     }
//
//     return TextEditingValue(
//       text: text,
//       selection: TextSelection.collapsed(offset: text.length),
//     );
//   }
// }



  //Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: <Widget>[
//                 CreditCardWidget(
//                   enableFloatingCard: useFloatingAnimation,
//                   cardNumber: controller.state.cardNumber.toString(),
//                   expiryDate: controller.state.expiryDate.toString(),
//                   cardHolderName: controller.state.zipCode.toString(),
//                   cvvCode: controller.state.cvc.toString(),
//                   bankName: 'Axis Bank',
//                   frontCardBorder: useGlassMorphism
//                       ? null
//                       : Border.all(color: Colors.grey),
//                   backCardBorder: useGlassMorphism
//                       ? null
//                       : Border.all(color: Colors.grey),
//                   showBackView: controller.state.isCvvFocused,
//                   obscureCardNumber: true,
//                   obscureCardCvv: true,
//                   isHolderNameVisible: true,
//                   cardBgColor: AppColors.buttonColor,
//                   isSwipeGestureEnabled: true,
//                   onCreditCardWidgetChange:
//                       (CreditCardBrand creditCardBrand) {},
//                   customCardTypeIcons: <CustomCardTypeIcon>[
//                     CustomCardTypeIcon(
//                       cardType: CardType.americanExpress,
//                       cardImage: Icon(Icons.credit_score_outlined,color: Colors.white,)
//                     ),
//                   ],
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         // CreditCardForm(
//                         //   formKey: _formKey,
//                         //   obscureCvv: true,
//                         //   obscureNumber: true,
//                         //   cardNumber: controller.state.cardNumber.toString(),
//                         //   expiryDate: controller.state.expiryDate.toString(),
//                         //   isHolderNameVisible: true,
//                         //   isCardNumberVisible: true,
//                         //   isExpiryDateVisible: true,
//                         //   cardHolderName: controller.state.zipCode.toString(),
//                         //   cvvCode: controller.state.cvc.toString(),
//                         //   inputConfiguration: const InputConfiguration(
//                         //     cardNumberDecoration: InputDecoration(
//                         //       labelText: 'Number',
//                         //       hintText: 'XXXX XXXX XXXX XXXX',
//                         //     ),
//                         //     expiryDateDecoration: InputDecoration(
//                         //       labelText: 'Expired Date',
//                         //       hintText: 'XX/XX',
//                         //     ),
//                         //     cvvCodeDecoration: InputDecoration(
//                         //       labelText: 'CVV',
//                         //       hintText: 'XXX',
//                         //     ),
//                         //     cardHolderDecoration: InputDecoration(
//                         //       labelText: 'Zip Code',
//                         //       hintText: 'XXX',
//                         //     ),
//                         //   ),
//                         //   // onCreditCardModelChange: onCreditCardModelChange,
//                         // ),
//                         const SizedBox(height: 20),
//                         GestureDetector(
//                           onTap: (){
//                             if (_formKey.currentState?.validate() ?? false) {
//                               print('valid!');
//                             } else {
//                               print('invalid!');
//                             }
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 8,
//                             ),
//                             decoration:  BoxDecoration(
//                               color: AppColors.buttonColor,
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(8),
//                               ),
//                             ),
//                             padding:
//                             const EdgeInsets.symmetric(vertical: 15),
//                             alignment: Alignment.center,
//                             child:  HeadingTextWidget(title: 'Save',textColor: Colors.white,fontWeight: FontWeight.w600,),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             )