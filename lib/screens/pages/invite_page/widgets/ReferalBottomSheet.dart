import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/invite_page/controller.dart';

Future<void> ReferalBottoSheet(BuildContext context,InviteCon controller) async {
  controller.generateCouponCode();
  showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              // color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(child: HeadingTextWidget(title: 'Invite Friends ',textColor: Theme.of(context).headingColor,)),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SubHeadingTextWidget(
                      title:
                          'Invite your firends and you will get \$30 discount on your checkout',
                      maxLines: 4,
                      textAlign: TextAlign.center,
                        textColor:Theme.of(context).headingColor,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: TextFormField(
                            enabled: true,
                            controller: controller.state.referralContr,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.refresh),
                                onPressed: (){
                                  controller.generateCouponCode();
                                },
                              ),
                            ),
                            style: GoogleFonts.openSans(
                                fontSize: 15,
                                color:Theme.of(context).headingColor,
                                fontWeight: FontWeight.bold
                            ),

                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Obx((){
                    return controller.state.shareLoading.value==false? RoundButton(
                      title: 'Send Invitation',
                      onPress: () {
                        controller.handelShareTap(controller.state.referralContr.text.trim().toString(), context);
                      },
                    ): Container(
                      child: Lottie.asset('assets/lottie/loading2.json',height: 100,width: 100),
                    );
                  })
                ],
              ),
            ),
          ),
        );
      });
}
