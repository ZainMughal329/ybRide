import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';
import 'package:yb_ride/screens/pages/Checkout/state.dart';
import '../../../../../main.dart';

Future promoCodeBottomSheet(BuildContext context,CheckOutCon cont) {
  final state = CheckOutState();

  final scrollController = ScrollController();
  final focusNode = FocusNode();
  state.promoCodeCon.addListener(() {
    if (state.promoCodeCon.text.trim().isNotEmpty) {
      state.buttonVisible.value = true;
    } else {
      state.buttonVisible.value = false;
    }
  });
  return showModalBottomSheet(
    // backgroundColor: Theme.of(context).scaffoldBgClr,
    isScrollControlled: true,
    useSafeArea: true,
    context: context,
    builder: (BuildContext context) {
      return Builder(builder: (BuildContext innerContext) {
        return SingleChildScrollView(
          controller: scrollController,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight:
                  mq.height * 0.9, // Set a maximum height for the bottom sheet
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBgClr,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 5, // Blur radius
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.horizontal_rule,
                    size: 40,
                    color: Colors.grey.shade400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: mq.width * .01),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.xmark),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // Close the bottom sheet
                          },
                        ),
                      ),
                      SizedBox(
                        width: mq.width * .15,
                      ),
                      HeadingTextWidget(
                        title: "Add promo code",
                        fontWeight: FontWeight.bold,
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black54,
                    thickness: 0.4,
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  ReuseableTextField(
                      contr: state.promoCodeCon,
                      focusNode: focusNode,
                      label: 'promo code',
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      obsecure: false),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  Obx(
                    () => state.buttonVisible.value
                        ? RoundButton(title: 'Apply promo code',
                        onPress: () {
                          if(state.promoCodeCon.text.trim().isNotEmpty){
                           cont.checkPromoCode(context,state.promoCodeCon.text.trim().toString());
                          }else{
                            Snackbar.showSnackBar("YB-Ride", "Enter valid code", Icons.question_mark_outlined);
                          }
                        },
                    )
                        : Container(),
                  ),
                  SizedBox(
                    height: mq.height * .1,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
