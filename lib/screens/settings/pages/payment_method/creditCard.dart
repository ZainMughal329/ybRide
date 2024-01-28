


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/controller.dart';
import '../../../../components/custom_Appbar.dart';
import '../../../../main.dart';
import '../../../../models/creditCart.dart';
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
        child:Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CreditCardWidget(
                  enableFloatingCard: useFloatingAnimation,
                  cardNumber: controller.state.cardNumber.toString(),
                  expiryDate: controller.state.expiryDate.toString(),
                  cardHolderName: controller.state.zipCode.toString(),
                  cvvCode: controller.state.cvc.toString(),
                  bankName: 'Axis Bank',
                  frontCardBorder: useGlassMorphism
                      ? null
                      : Border.all(color: Colors.grey),
                  backCardBorder: useGlassMorphism
                      ? null
                      : Border.all(color: Colors.grey),
                  showBackView: controller.state.isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  isHolderNameVisible: true,
                  cardBgColor: AppColors.buttonColor,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.americanExpress,
                      cardImage: Icon(Icons.credit_score_outlined,color: Colors.white,)
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // CreditCardForm(
                        //   formKey: _formKey,
                        //   obscureCvv: true,
                        //   obscureNumber: true,
                        //   cardNumber: controller.state.cardNumber.toString(),
                        //   expiryDate: controller.state.expiryDate.toString(),
                        //   isHolderNameVisible: true,
                        //   isCardNumberVisible: true,
                        //   isExpiryDateVisible: true,
                        //   cardHolderName: controller.state.zipCode.toString(),
                        //   cvvCode: controller.state.cvc.toString(),
                        //   inputConfiguration: const InputConfiguration(
                        //     cardNumberDecoration: InputDecoration(
                        //       labelText: 'Number',
                        //       hintText: 'XXXX XXXX XXXX XXXX',
                        //     ),
                        //     expiryDateDecoration: InputDecoration(
                        //       labelText: 'Expired Date',
                        //       hintText: 'XX/XX',
                        //     ),
                        //     cvvCodeDecoration: InputDecoration(
                        //       labelText: 'CVV',
                        //       hintText: 'XXX',
                        //     ),
                        //     cardHolderDecoration: InputDecoration(
                        //       labelText: 'Zip Code',
                        //       hintText: 'XXX',
                        //     ),
                        //   ),
                        //   // onCreditCardModelChange: onCreditCardModelChange,
                        // ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: (){
                            if (_formKey.currentState?.validate() ?? false) {
                              print('valid!');
                            } else {
                              print('invalid!');
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration:  BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            padding:
                            const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            child:  HeadingTextWidget(title: 'Save',textColor: Colors.white,fontWeight: FontWeight.w600,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) ,
      ),
    );
  }
  // void onCreditCardModelChange(CreditCardModel creditcardmodel) {
  //   final controller = Get.find<PaymentCon>();
  //   Obx(()=>
  //   Text(
  //   controller.state.cardNumber.value.text
  //   )
  //   );
  //   Obx(()=>
  //       Text(
  //           controller.state.expiryDate.value.text
  //       )
  //   );
  //   Obx(()=>
  //       Text(
  //           controller.state.cvc.value.text
  //       )
  //   );
  //   Obx(()=>
  //       Text(
  //           controller.state.cvc.value.text
  //       )
  //   );
  //   Obx(()=>
  //       Text(
  //           controller.state.cvc.value.text
  //       )
  //   );
  //   // Obx(()=>
  //   //     Text(
  //   //         controller.state.isCvvFocused.value = creditCardModel.isCvvFocused
  //   //     )
  //   // );
  //
  //
  // }
}



