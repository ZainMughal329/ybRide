import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';

class BookNowView extends GetView<BookViewController> {
  const BookNowView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(42.361145, -71.057083),
              zoom: 12,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    height: mq.height * 0.20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                        color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: mq.height * 0.010),
                          child: RoundButton(
                            title: 'Start Searching',
                          onPress: (){
                            Get.bottomSheet(
                              Container(
                                height: mq.height * 0.6,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment : MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.horizontal_rule,
                                          size: 40,
                                          color: Colors.grey.shade400,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: HeadingTextWidget(title: "Where & When",fontWeight: FontWeight.w500,),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                              isDismissible: true,
                              enterBottomSheetDuration: Duration(milliseconds: 400),
                              exitBottomSheetDuration: Duration(milliseconds: 400),
                            );
                          },
                          ),
                        ),
                      ],
                    ),

                  ),
                  onTap: () {


                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
