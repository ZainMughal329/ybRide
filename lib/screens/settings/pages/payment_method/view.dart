


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
  const PaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,

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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * .09, vertical: mq.height * .05),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                      onTap: (){
                        PersistentNavBarNavigator.pushNewScreen(context, screen: CreditCardScreen(),withNavBar: true);
                      },
                      child: HeadingTextWidget(title: 'Add payment method',textColor: AppColors.buttonColor,fontSize: 16,fontWeight: FontWeight.w600,))),
              SizedBox(height: mq.height*.02,),
              Divider(),
              SizedBox(height: mq.height*.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SubHeadingTextWidget(title: 'Your credits',fontWeight: FontWeight.w600,textColor: Theme.of(context).lightTextColor,),
                  SubHeadingTextWidget(title: '\$0.00',textColor: Theme.of(context).lightTextColor)
                ],
              )
            ],
          ),
        ),
        
      ),
    );
  }
}
