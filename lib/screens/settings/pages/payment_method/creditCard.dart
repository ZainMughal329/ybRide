


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/controller.dart';
import '../../../../components/custom_Appbar.dart';
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
                ),

              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      // padding: const EdgeInsets.symmetric(vertical: 8.0),
                      margin: const EdgeInsets.only( top: 8),
                      child: ReuseableTextField(
                        contr: controller.state.expiryDate,
                        label: 'MM/YY ',
                        textInputAction: TextInputAction.next,
                        obsecure: false,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(5),
                          ExpiryDateInputFormatter(),
                        ],

                      ),
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
              RoundButton(title: 'Save', onPress: (){
                controller.saveCreditCardDataToFirestore(
                    controller.state.documentId,
                    controller.state.cardNumber.text.trim(),
                    controller.state.expiryDate.text.trim(),
                    controller.state.zipCode.text.trim(),
                    controller.state.cvc.text.trim(),
                );
              })
            ]
        ),
      ),
    );
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    if (text.length == 3 && !text.contains('/')) {
      return TextEditingValue(
        text: '${text.substring(0, 2)}/${text.substring(2)}',
        selection: TextSelection.collapsed(offset: 3),
      );
    } else if (text.length == 4) {
      final month = text.substring(0, 2);
      final year = text.substring(2);
      if (int.tryParse(year) == null || !isValidExpiryDate(month, year)) {
        // Handle non-numeric input for the year or invalid expiry date
        return oldValue;
      }
      return TextEditingValue(
        text: '$month/$year',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    return newValue;
  }

  bool isValidExpiryDate(String month, String year) {
    final currentYear = DateTime.now().year % 100;
    final enteredYear = int.tryParse(year) ?? 0;

    return enteredYear > currentYear || (enteredYear == currentYear && monthValid(month));
  }

  bool monthValid(String month) {
    final intMonth = int.tryParse(month) ?? 0;
    return intMonth >= 1 && intMonth <= 12;
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