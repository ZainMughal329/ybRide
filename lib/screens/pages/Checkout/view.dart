import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/agePolicy.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/coverge_sheet.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/delivery_process_read_more.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/driverLicensealertbox.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/promoCodeWidget.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/viewInstructionsBottomSheet.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';
import 'package:yb_ride/screens/settings/pages/payment_method/creditCard.dart';
import '../../../components/custom_Appbar.dart';
import '../../../main.dart';
class CheckOutScreen extends GetView<CheckOutCon> {
  final double carRent;
   CheckOutScreen({super.key,required this.carRent});
  final controller = Get.put(CheckOutCon());

  @override
  Widget build(BuildContext context) {
    print("Car Rent is"+carRent.toString());
    controller.state.totalPrice.value=carRent;
    final controller2 = Get.put<CarDetailsController>(CarDetailsController());
    Get.put(CheckOutCon());
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      // AppBAr section
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(mq.height * .08),
          child: CustomAppBarWidget(
            centerTitle: 'Checkout',
            isLeading: true,
            leadingIcon: Icons.arrow_back_ios,
            leadingPress: (){
              Navigator.pop(context);
            },
          )),
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(bottom: mq.height * .07, top: 0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
                vertical: mq.height * .03, horizontal: mq.width * .05),
            children: [
              // Drive Container
              Obx(
                    () => controller.state.isContainerVisible.value
                    ? Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mq.height * .02,
                        horizontal: mq.width * .03),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 13,
                              ),
                              backgroundColor: AppColors.buttonColor,
                              radius: 8,
                            ),
                            SizedBox(
                              width: mq.width * .02,
                            ),
                            HeadingTextWidget(
                              title: 'Weekday Savings Included',
                              textColor: AppColors.buttonColor,
                              fontSize: 14,
                            ),
                            SizedBox(
                              width: mq.width * .12,
                            ),
                            GestureDetector(
                                onTap: () {
                                  controller.hideContainer();
                                },
                                child: Icon(
                                  FontAwesomeIcons.xmark,
                                  color: Theme.of(context).headingColor,
                                  size: 16,
                                ))
                          ],
                        ),
                        SizedBox(
                          height: mq.height * .01,
                        ),
                        SubHeadingTextWidget(
                          title:
                          'Your booking includes a weekday -you have the best prices 💸',
                          textColor: Theme.of(context).lightTextColor,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBgClr,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1))
                      ],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).scaffoldBgClr)),
                )
                    : SizedBox(),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              // Promo code section
              HeadingTextWidget(
                title: 'Have a promo code?',
                fontSize: 18,
                textColor: Theme.of(context).headingColor,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              GestureDetector(
                onTap: () {
                  promoCodeBottomSheet(context);
                },
                child: Container(
                  height: mq.height * .08,

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mq.height * .02, horizontal: mq.width * .02),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: mq.width * .18,
                            ),
                            HeadingTextWidget(
                              title: 'Add promo code',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              textColor: Theme.of(context).headingColor,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBgClr,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.1))
                      ],
                      border: Border.all(color: Colors.black12)),
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Vehicle section or chnge a car
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'Economy',
                            fontSize: 14,
                            textColor: Theme.of(context).headingColor,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: '5 seats . 1 suitcases',
                            fontSize: 14,
                            textColor: Theme.of(context).lightTextColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: mq.width * .2,
                      ),
                      Container(
                        height: mq.height * .08,
                        width: mq.width * .3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image(
                          image: AssetImage('assets/images/3.png'),
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: mq.width * .65),
                      child: InkWell(
                        onTap: (){
                          Get.to(CarDetailsScreen(isTextShow: true),);
                        },
                        child: HeadingTextWidget(
                          title: 'Change car',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          textColor: AppColors.buttonColor,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Getting the vehicle
              HeadingTextWidget(
                title: 'Getting the vehicle',
                textColor: Theme.of(context).headingColor,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'Delivery',
                            fontSize: 14,
                            textColor: Theme.of(context).headingColor,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: 'Your home,hotel or other address',
                            fontSize: 14,
                            textColor: Theme.of(context).lightTextColor,
                          )
                        ],
                      ),
                      Spacer(),
                      Obx(
                            () => Checkbox(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.grey.withOpacity(.1), width: .5),
                          ),
                          visualDensity: VisualDensity.compact,
                          value: controller.state.vehicle_delivery.value,
                          onChanged: (bool? value) {
                            controller.state.vehicle_delivery.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'Pickup',
                            fontSize: 14,
                            textColor: Theme.of(context).headingColor,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: 'Your home,hotel or other address',
                            fontSize: 14,
                            textColor: Theme.of(context).lightTextColor,
                          ),
                        ],
                      ),
                      Spacer(),
                      Obx(
                            () => Checkbox(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: Colors.grey.withOpacity(.1), width: .5),
                          ),
                          visualDensity: VisualDensity.compact,
                          value: controller.state.vehicle_pickup.value,
                          onChanged: (bool? value) {
                            controller.state.vehicle_pickup.value = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                title:
                'Pick up your YbRide within a 2-hour window from your scheduled start.',
                fontWeight: FontWeight.w500,
                fontSize: 13,
                textColor: Theme.of(context).lightTextColor,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              HeadingTextWidget(
                title: 'View instructions',
                textColor: AppColors.buttonColor,
                fontSize: 15,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Where and When
              HeadingTextWidget(
                title: 'Where & When',
                textColor: Theme.of(context).headingColor,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: Theme.of(context).headingColor,
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: mq.width * 0.7,
                        // Set a fixed width for the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(
                              title:
                              '844 11th Avenue, 844 11th Avenue, New York, NY 10019',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              maxLines: 2,
                              textColor: Theme.of(context).headingColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: HeadingTextWidget(
                            title: 'Edit',
                            fontSize: 15,
                            textColor: AppColors.buttonColor,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: Theme.of(context).headingColor,
                      ),
                      SizedBox(width: 14),
                      Container(
                        width: mq.width * 0.7,
                        // Set a fixed width for the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(
                              title:
                              '844 11th Avenue, 844 11th Avenue, New York, NY 10019',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              maxLines: 2,
                              textColor: Theme.of(context).headingColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: HeadingTextWidget(
                            title: 'Edit',
                            fontSize: 15,
                            textColor: AppColors.buttonColor,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 20,
                        color: Theme.of(context).headingColor,
                      ),
                      SizedBox(width: 8),
                      Container(
                        width: mq.width * 0.7,
                        // Set a fixed width for the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(
                              title: 'Jan 05, 11.00 AM',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              maxLines: 2,
                              textColor: Theme.of(context).headingColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: mq.height * .006,
                            ),
                            HeadingTextWidget(
                              title: 'Feb 05, 11.00 AM',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              maxLines: 2,
                              textColor: Theme.of(context).headingColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {},
                          child: HeadingTextWidget(
                            title: 'Edit',
                            fontSize: 15,
                            textColor: AppColors.buttonColor,
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Delivery process
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/clock.jpeg'),height: mq.height*.05,width: mq.width*.05,),
                      SizedBox(width: 8),
                      HeadingTextWidget(
                        title: 'Delivery process',
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              HeadingTextWidget(
                title:
                'Your YBRide Surfer will wait 10 minutes upon arrival (at least until 12.40 PM),',
                fontSize: 14,
                textColor: Theme.of(context).headingColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: mq.height * .004,
              ),
              SubHeadingTextWidget(
                title:
                "We will keep you updated on your surfer's estimated arrival time through text and/ or push notifications. Enjoy your trip!",
                fontSize: 13,
                textColor: Theme.of(context).lightTextColor,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              GestureDetector(
                onTap: (){
                  deliveryProcessSheet(context);
                },
                child: HeadingTextWidget(
                  title: 'Read more',
                  fontSize: 14,
                  textColor: AppColors.buttonColor,
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              // Coverage
              HeadingTextWidget(
                title: 'Coverage',
                textColor: Theme.of(context).headingColor,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'Standard Protection',
                            textColor: Theme.of(context).headingColor,

                            fontSize: 14,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: '\$53.98 | day',
                            textColor: Theme.of(context).lightTextColor,

                            fontSize: 14,
                          )
                        ],
                      ),
                      Spacer(),
                      Obx(() =>_checkBox(controller.state.standard_protection.value, (value) {
                        controller.state.standard_protection.value = value!;
                        controller.updateTotalPrice_Coverage_std_prot();
                      }, context), ),


                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                title:
                'Provides liability insurance which is a mandatory legal requirement in all 50 states, covers any damage done to the car past a \$500 deduction. Includes Roadside Assistance.',
                fontWeight: FontWeight.w500,
                textColor: Theme.of(context).lightTextColor,

                fontSize: 13,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            textColor: Theme.of(context).headingColor,
                            title: 'Essential Protection',
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: '\$28.98 | day',
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 14,
                          )
                        ],
                      ),
                      Spacer(), // Add spacing between text and circle
                      Obx(() =>_checkBox(controller.state.essential_protection.value, (value) {
                        controller.state.essential_protection.value = value!;
                        controller.updateTotalPrice_Coverage_essential_prot();
                      }, context), ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                title:
                'Provides liability insurance which is a mandatory legal requirement in all 50 states, Driving without liability insurance us illegal',
                textColor: Theme.of(context).lightTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'I have my own',
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: '\$0.00 | day',
                            textColor: Theme.of(context).lightTextColor,
                            fontSize: 14,
                          )
                        ],
                      ),
                      Spacer(), // Add spacing between text and circle
                      Obx(() =>_checkBox(controller.state.i_have_own.value, (value) {
                        controller.state.i_have_own.value = value!;
                        controller.updateTotalPrice_Coverage_have_Own();
                      }, context), ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                title:
                'You have your own insurance that complies with local requirements. You understand that it is illegal to drive without liability insurance, and that you will be liable for any damage done to a 3rd party.',
                textColor: Theme.of(context).lightTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              GetBuilder<CheckOutCon>(builder: (con) {
                return InkWell(
                  onTap: () {
                    controller.init();
                    coverageBottomSheet(context, controller);
                  },
                  child: HeadingTextWidget(
                    title: 'Add custom coverage',

                    fontSize: 16,
                    textColor: AppColors.buttonColor,
                  ),
                );
              }),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Extras section
              HeadingTextWidget(
                textColor: Theme.of(context).headingColor,
                title: 'Extras',
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'Unlimited miles',
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            textColor: Theme.of(context).lightTextColor,
                            title: '\$13.00 | day',
                            fontSize: 14,
                          )
                        ],
                      ),
                      Spacer(), // Add spacing between text and circle
                      Obx(
                            () => _switchButton(
                          controller.state.extraSwitchVal.value,
                              (value) {
                            controller.state.extraSwitchVal.value = value;
                            controller.updateTotalPrice_Extras();
                          },
                          context,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                  title:
                  'Your rental includes 1800 miles. You will pay \$0.45/mile thereafter.',
                  textColor: Theme.of(context).lightTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Drivers Section
              HeadingTextWidget(
                textColor: Theme.of(context).headingColor,
                title: 'Drivers',
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueGrey.withOpacity(.3),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).headingColor,
                        ),
                      ),
                      SizedBox(
                        width: mq.width * .03,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(
                            title: 'You',
                            textColor: Theme.of(context).headingColor,
                            fontSize: 14,
                          ),
                          SizedBox(
                            height: mq.height * .002,
                          ),
                          SubHeadingTextWidget(
                            title: 'Not verified',
                            fontSize: 14,
                            textColor: Colors.red.withOpacity(.6),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Row(
                children: [
                  Obx(() =>_checkBox(controller.state.driversCheckBoxVal.value, (value) {
                    controller.state.driversCheckBoxVal.value = value!;
                    controller.updateTotalPrice_Drivers();
                  }, context), ),
                  SizedBox(width: mq.width * 0.002),
                  SubHeadingTextWidget(
                      textColor: Theme.of(context).lightTextColor,
                      title: 'I am under 25 years old', fontSize: 14),
                  SizedBox(width: mq.width * 0.02),
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: Theme.of(context).headingColor,

                    child: Icon(
                      Icons.question_mark,
                      color: Colors.white,
                      size: 8,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: mq.height * .01,
              ),
              SubHeadingTextWidget(
                title:
                "Drivers License verification is required, you'll receive instructions after payment.",
                textColor: Theme.of(context).lightTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              SubHeadingTextWidget(
                title: 'Add additional driver fee of cost after bookings!',
                textColor: Theme.of(context).lightTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              GestureDetector(onTap: (){
                showCustomAlertDialog(context);
              },
                child: HeadingTextWidget(
                    title: 'See Details',
                    fontSize: 16,
                    textColor: AppColors.buttonColor),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Deposit Policy section
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/card.jpeg'),height: mq.height*.05,width: mq.width*.05,),
                      SizedBox(width: 8),
                      HeadingTextWidget(title: 'Deposit policy',
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                title:
                'A temporary deposit of \$300.00(\$500.00 for debit cards)will be held on your card 24 hours before your trip starts. Typically, YbRide releases this deposit 3 days after your trip ends, but your bank may take an additional 5-10 business days for processing. Trips longer than 27 days will have the deposit captured and refunded after your trip',
                textColor: Theme.of(context).lightTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Minimum age policy
              HeadingTextWidget(
                textColor: Theme.of(context).headingColor,
                title: 'Minimum age policy',
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              InkWell(
                onTap: (){
                  agePolicySheet(context);
                },
                child: HeadingTextWidget(
                  title: 'Open minimum age policy',
                  textColor: AppColors.buttonColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              // Cancelation policy
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(image: AssetImage('assets/images/signals.jpeg'),height: mq.height*.05,width: mq.width*.05,),
                      SizedBox(width: 8),
                      HeadingTextWidget(title: 'Cancellation policy',
                        textColor: Theme.of(context).headingColor,

                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              SubHeadingTextWidget(
                title:
                "Free cancellation until 48h before start. By closing the booking, you confirm that you've read and accepted the trip information and the terms and conditions",
                textColor: Theme.of(context).lightTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              GestureDetector(
    onTap:(){
    viewInstructionsBottomSheet(context);
    },
                child: HeadingTextWidget(
                  title: 'See terms and conditions',
                  textColor: AppColors.buttonColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              Divider(
                color: Colors.black54,
                thickness: .2,
              ),
              SizedBox(
                height: mq.height * .02,
              ),
              // Payment method
              HeadingTextWidget(
                textColor: Theme.of(context).headingColor,
                title: 'Payment method',
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              GestureDetector(
              onTap: (){
                Get.to(()=>CreditCardScreen());
              },
                child: HeadingTextWidget(
                  title: 'Add payment method',
                  textColor: AppColors.buttonColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              GestureDetector(
                onTap: (){
                  promoCodeBottomSheet(context);
                },
                child: HeadingTextWidget(
                  title: 'Add promo code',
                  textColor: AppColors.buttonColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: mq.height * .03,
              ),
              SizedBox(
                height: mq.height * .05,
              ),
            ],
          ),
        ),
        // Button Section
        Positioned(
            bottom: mq.height * 0,
            left: mq.width * 0,
            right: mq.width * 0,
            child: Container(
              height: mq.height * .14,
              // Adjust the height based on your design
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBgClr,
                  border: Border.all(color: Colors.grey.shade100),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                  // topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01, horizontal: mq.width * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    HeadingTextWidget(
                                      title: 'Total price',
                                      textColor: Theme.of(context).headingColor,
                                      fontSize: 15,
                                    ),
                                    SizedBox(width: mq.width * 0.02),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Theme.of(context).headingColor,
                                      child: Icon(
                                        Icons.question_mark,
                                        color:   Theme.of(context).scaffoldBgClr,
                                        size: 8,
                                      ),
                                    ),
                                  ],
                                ),
                                Obx(()=>
                                   SubHeadingTextWidget(
                                    title:'\$${controller.state.totalPrice.value.toStringAsFixed(2)}',
                                    fontSize: 13,
                                    textColor: Theme.of(context).lightTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                    SizedBox(width: mq.width * 0.06),
                    Padding(
                      padding: EdgeInsets.only(bottom: mq.height * .017),
                      child: Container(
                        height: 50,
                        width: 170,
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor.withOpacity(0.8),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                            // topRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                            child: HeadingTextWidget(
                              title: 'Add personal data',
                              textColor: Colors.white,
                              fontSize: 14,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ]),
    );
  }
}

Widget _switchButton(bool val, ValueChanged<bool>? onChanged,BuildContext context) {
  return Switch(
    inactiveThumbColor: Theme.of(context).lightTextColor,
    inactiveTrackColor: Colors.transparent,
    activeColor:Theme.of(context).scaffoldBgClr,
    activeTrackColor: AppColors.buttonColor,
    value: val,
    onChanged: (value) {
      onChanged?.call(value);
    },
  );
}
Widget _checkBox(bool val, ValueChanged<bool>? onChanged,BuildContext context){
  return Checkbox(
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
              color: Colors.grey.withOpacity(.1),width: .5
          )
      ),
      visualDensity: VisualDensity.compact,
      value: val, onChanged: (bool? value) {
    onChanged?.call(value!);
  });
}



