import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_helpers.dart';
import 'package:yb_ride/screens/settings/pages/faqs/controller.dart';
import 'package:yb_ride/screens/settings/pages/faqs/show_faqs/view.dart';
import 'package:lottie/lottie.dart';

import '../../../../main.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  Widget _buildCard(String title, String val, IconData iconData,
      BuildContext context, VoidCallback onPress) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 150,
        width: mq.width * .9,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.buttonColor,
            width: 0.2,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).scaffoldBgClr,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).headingColor.withOpacity(.1),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              Icon(
                iconData,
                color: AppColors.buttonColor,
                size: 25,
              ),
              SizedBox(
                height: 20,
              ),
              HeadingTextWidget(
                title: title,
                textColor: Theme.of(context).headingColor,
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
              SizedBox(
                height: 20,
              ),
              SubHeadingTextWidget(
                title: val + ' articles',
                textColor: Theme.of(context).lightTextColor,
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Lottie.asset('assets/lottie/loading2.json'),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final con = Get.put(FAQController());
    con.fetchData();
    return Obx(
            () => con.loaded.value == false
            ? Scaffold(
              body: _buildLoadingWidget(context),
            )
            :  Scaffold(
        backgroundColor: Theme.of(context).scaffoldBgClr,
        appBar: CustomAppBarWidget(
          centerTitle: "FAQ's",
          isLeading: true,
          leadingIcon: Icons.arrow_back,
          leadingPress: () {
            Navigator.pop(context);
          },
        ),
        body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Getting Started',
                              con.gettingStartedArticles.value.toString(),
                              Icons.star_rate_outlined,
                              context,
                              () {
                                Get.to(
                                  ShowFAQs(
                                      collectionName: 'gettingStarted',
                                      appBarTitle: 'Getting Started'),
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Booking Changes & Cancellations',
                              con.bookingChargesArticles.value.toString(),
                              Icons.bookmark_added_sharp,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Booking Changes & Cancellation',
                                  collectionName: 'bookingChanges',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Delivery & Return',
                              con.deliveryAndReturnArticles.value.toString(),
                              Icons.location_on_outlined,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Delivery & Return',
                                  collectionName: 'deliveryReturn',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Deposits, Charges, Payments & Referrals',
                              con.depositsArticles.value.toString(),
                              Icons.payments_outlined,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Deposits, Charges, Payments & Referrals',
                                  collectionName: 'deposits',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Electric Vehicles (EV)',
                              con.evArticles.value.toString(),
                              Icons.electric_bolt_sharp,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Electric Vehicles (EV)',
                                  collectionName: 'electricVehicles',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Insurance, Accidents & Incidents',
                              con.insuranceArticles.value.toString(),
                              Icons.developer_board_off_outlined,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Insurance, Accidents, & Incidents',
                                  collectionName: 'insurance',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Self-Pickup and Return',
                              con.selfPickupANdReturnArticles.value.toString(),
                              Icons.location_on_outlined,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Self PickUp and Return',
                                  collectionName: 'selfPickup',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Vehicles & Equipment',
                              con.vehicleAndEquipmentArticles.value.toString(),
                              Icons.fire_truck,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Vehicles & Equipments',
                                  collectionName: 'vehiclesEquipments',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _buildCard(
                              'Verification & Driver Requirements',
                              con.verificationArticles.value.toString(),
                              Icons.person_3_outlined,
                              context,
                              () {
                                Get.to(ShowFAQs(
                                  appBarTitle: 'Verification & Driver Requirements',
                                  collectionName: 'verification',
                                ));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }
}
