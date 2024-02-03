import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import '../../../../components/custom_Appbar.dart';
import '../../../../main.dart';
import 'controller.dart';
import 'creditCard.dart';

class PaymentScreen extends GetView<PaymentCon> {
  PaymentScreen({super.key});
  final controller = Get.put(PaymentCon());
  @override
  Widget build(BuildContext context) {
    controller.fetchCardDetails();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * .09, vertical: mq.height * .05),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Obx(() {
                  return controller.state.cardExist.value == true
                      ? Container(
                          child: controller.state.cardType.value == 'visa'
                              ? paymentCard('visaCard.png', context)
                              : controller.state.cardType.value == "master"
                                  ? paymentCard('masterCard.png', context)
                                  : controller.state.cardType.value == "default"
                                      ? paymentCard('invite.png', context)
                                      : Container(),
                        )
                      : InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(context,
                                screen: CreditCardScreen(), withNavBar: true);
                          },
                          child: HeadingTextWidget(
                            title: 'Add payment method',
                            textColor: AppColors.buttonColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ));
                }),
              ),

              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Obx(
              //     () {
              //       return
              //       controller.state.cardType.value == 'visa'
              //           ? paymentCard('visaCard.png', context)
              //           : controller.state.cardType.value == "master"
              //               ? paymentCard('masterCard.png', context)
              //               : controller.state.cardType.value == "default"
              //                   ? paymentCard('invite.png', context)
              //                   : controller.state.cardType.value == ""
              //                       ? InkWell(
              //                           onTap: () {
              //                             PersistentNavBarNavigator
              //                                 .pushNewScreen(context,
              //                                     screen: CreditCardScreen(),
              //                                     withNavBar: true);
              //                           },
              //                           child: HeadingTextWidget(
              //                             title: 'Add payment method',
              //                             textColor: AppColors.buttonColor,
              //                             fontSize: 16,
              //                             fontWeight: FontWeight.w600,
              //                           )):Container();
              //     },
              //   ),
              // ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(),
              SizedBox(
                height: mq.height * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubHeadingTextWidget(
                    title: 'Your credits',
                    fontWeight: FontWeight.w600,
                    textColor: Theme.of(context).lightTextColor,
                  ),
                  SubHeadingTextWidget(
                      title: '\$0.00',
                      textColor: Theme.of(context).lightTextColor)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentCard(String cardImage, BuildContext context) {
    return Container(
      // height: mq.height*0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            color: Theme.of(context).scaffoldBgClr,
            child: Image.asset('assets/appImages/${cardImage}'),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "****************",
            style: TextStyle(
              color: Theme.of(context).headingColor,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Theme.of(context).headingColor,
            ),
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(context,
                  screen: CreditCardScreen(), withNavBar: true);
            },
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Theme.of(context).headingColor,
            ),
            onPressed: () {
              controller.delCard(context);
            },
          ),
        ],
      ),
    );
  }
}
