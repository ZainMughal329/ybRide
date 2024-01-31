


import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/routes/routes_name.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/driverLicensealertbox.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/promoCodeWidget.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/viewInstructionsBottomSheet.dart';

import '../../../components/custom_Appbar.dart';
import '../../../main.dart';
import '../../settings/pages/payment_method/creditCard.dart';

class CheckOutScreen extends GetView<CheckOutCon> {
  const CheckOutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(mq.height* .08), child:CustomAppBarWidget(centerTitle: 'Checkout',isLeading: true,) ),
      body:Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: mq.height*.07,top: 0),
            child: ListView(
              physics: BouncingScrollPhysics(),
              padding:EdgeInsets.symmetric(vertical: mq.height*.03,horizontal: mq.width*.05),
              children: [
                // Weekday Savings include section
                Obx(()=> controller.state.isContainerVisible.value?
                   Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: mq.height*.02,horizontal: mq.width*.03),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.done,color: Colors.white,size: 13,),
                                backgroundColor: AppColors.buttonColor,
                                radius: 8,
                              ),
                              SizedBox(width: mq.width*.02,),
                              HeadingTextWidget(title: 'Weekday Savings Included',textColor: AppColors.buttonColor,fontSize: 14,),
                              SizedBox(width: mq.width*.12,),
                              GestureDetector(
                                  onTap:(){
                                    controller.hideContainer();
                                  },
                                  child: Icon(FontAwesomeIcons.xmark,color: Colors.black,size: 16,))
                            ],
                          ),
                          SizedBox(height: mq.height*.01,),
                          SubHeadingTextWidget(title: 'Your booking includes a weekday -you have the best prices 💸'),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white
                      )

                    ),
                  ):SizedBox(),),
                SizedBox(height: mq.height*.03,),
                //  have a promo code section
                HeadingTextWidget(title: 'Have a promo code?',fontSize:18,),
                SizedBox(height: mq.height*.02,),
                GestureDetector(
                  onTap: (){
                    promoCodeBottomSheet(
                      context
                    );
                  },
                  child: Container(
                    height: mq.height*.08,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: mq.height*.02,horizontal: mq.width*.02),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.yellow,),
                              SizedBox(width:mq.width*.18,),
                              HeadingTextWidget(title: 'Add promo code',fontSize: 15,fontWeight: FontWeight.w600,)
                            ],
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1))],
                        border: Border.all(
                            color: Colors.black12
                        )
                    ),
                  ),
                ),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Economy Section
                Column(
                  children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingTextWidget(title: 'Economy',fontSize: 14,),
                          SizedBox(height: mq.height*.002,),
                          SubHeadingTextWidget(title: '5 seats . 1 suitcases',fontSize: 14,)
                        ],
                      ),
                      SizedBox(width: mq.width*.2,),
                      Container(
                        height: mq.height*.08,
                        width: mq.width*.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Image(
                          image:AssetImage('assets/images/3.png') ,
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ) ,
                     SizedBox(height: mq.height*.02,),
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RoutesName.carDetailsScreen);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: mq.width*.65),
                          child: HeadingTextWidget(title: 'Change car',fontWeight: FontWeight.w600,fontSize: 14,textColor:AppColors.buttonColor,)),
                    )
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Getting the vehicle section
                HeadingTextWidget(title: 'Getting the vehicle'),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'Delivery',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: 'Your home,hotel or other address',fontSize: 14,)
                          ],
                        ),
                        Spacer(), // Add spacing between text and circle
                        Container(
                          width: 15, // Adjust the size of the circle
                          height: 15, // Adjust the size of the circle
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1))
                              ]
                          ),
                          child: Icon(
                            Icons.check, // Use the correct icon based on selection
                            size: 13,
                            color: Colors.white, // Use the color based on selection
                          ),
                        ),
            
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'Pickup',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: 'Your home,hotel or other address',fontSize: 14,)
                          ],
                        ),
                        Spacer(), // Add spacing between text and circle
                        Container(
                          width: 15, // Adjust the size of the circle
                          height: 15, // Adjust the size of the circle
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1))
                            ]
                          ),
                          child: Icon(
                            Icons.check, // Use the correct icon based on selection
                            size: 13,
                            color: Colors.white, // Use the color based on selection
                          ),
                        ),
                        // SizedBox(width: mq.width*.2,),
            
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                SubHeadingTextWidget(title: 'Pick up your YbRide within a 2-hour window from your scheduled start.',fontWeight: FontWeight.w500,fontSize: 13,),
                SizedBox(height: mq.height*.02,),
                GestureDetector(
                    onTap: (){
                      viewInstructionsBottomSheet(context);
                    },
                    child: HeadingTextWidget(title: 'View instructions',textColor: AppColors.buttonColor,fontSize: 15,)),
                SizedBox(height: mq.height*.02,),
                // Where and When section
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                HeadingTextWidget(title: 'Where & When'),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: mq.width * 0.7, // Set a fixed width for the container
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingTextWidget(
                                title: '844 11th Avenue, 844 11th Avenue, New York, NY 10019',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                          },
                          child: HeadingTextWidget(title: 'Edit',fontSize: 15,textColor: AppColors.buttonColor,)
            
                        ),
                  ],
                ),
              ],
            ),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.black,
                        ),
                        SizedBox(width: 14),
                        Container(
                          width: mq.width * 0.7, // Set a fixed width for the container
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingTextWidget(
                                title: '844 11th Avenue, 844 11th Avenue, New York, NY 10019',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                            },
                            child: HeadingTextWidget(title: 'Edit',fontSize: 15,textColor: AppColors.buttonColor,)
            
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: mq.width * 0.7, // Set a fixed width for the container
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeadingTextWidget(
                                title: 'Jan 05, 11.00 AM',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: mq.height*.006,),
                              HeadingTextWidget(
                                title: 'Feb 05, 11.00 AM',
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
            
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                            },
                            child: HeadingTextWidget(title: 'Edit',fontSize: 15,textColor: AppColors.buttonColor,)
            
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Delivery process
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/clock.jpeg'),height: mq.height*.05,width: mq.width*.05,),
                        SizedBox(width: 8),
                        HeadingTextWidget(title: 'Delivery process')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                HeadingTextWidget(title: 'Your YBRide Surfer will wait 10 minutes upon arrival (at least until 12.40 PM),',fontSize: 14,fontWeight: FontWeight.w600,),
                SizedBox(height: mq.height*.004,),
                SubHeadingTextWidget(title: "We will keep you updated on your surfer's estimated arrival time through text and/ or push notifications. Enjoy your trip!",fontSize: 13,fontWeight: FontWeight.w500,),
                SizedBox(height: mq.height*.02,),
                HeadingTextWidget(title: 'Read more',fontSize: 14,textColor: AppColors.buttonColor,),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                //  Coverage section
                HeadingTextWidget(title: 'Coverage'),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'Standard Protection',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: '\$53.98 | day',fontSize: 14,)
                          ],
                        ),
                        Spacer(), // Add spacing between text and circle
                        Container(
                          width: 15, // Adjust the size of the circle
                          height: 15, // Adjust the size of the circle
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1))
                              ]
                          ),
                          child: Icon(
                            Icons.check, // Use the correct icon based on selection
                            size: 13,
                            color: Colors.white, // Use the color based on selection
                          ),
                        ),
            
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
            SubHeadingTextWidget(title: 'Provides liability insurance which is a mandatory legal requirement in all 50 states, covers any damage done to the car past a \$500 deduction. Includes Roadside Assistance.',fontWeight: FontWeight.w500,fontSize: 13,),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'Essential Protection',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: '\$28.98 | day',fontSize: 14,)
                          ],
                        ),
                        Spacer(), // Add spacing between text and circle
                        Container(
                          width: 15, // Adjust the size of the circle
                          height: 15, // Adjust the size of the circle
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1))
                              ]
                          ),
                          child: Icon(
                            Icons.check, // Use the correct icon based on selection
                            size: 13,
                            color: Colors.white, // Use the color based on selection
                          ),
                        ),
            
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                SubHeadingTextWidget(title: 'Provides liability insurance which is a mandatory legal requirement in all 50 states, Driving without liability insurance us illegal',fontWeight: FontWeight.w500,fontSize: 13,),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'I have my own',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: '\$0.00 | day',fontSize: 14,)
                          ],
                        ),
                        Spacer(), // Add spacing between text and circle
                        Container(
                          width: 15, // Adjust the size of the circle
                          height: 15, // Adjust the size of the circle
                          decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(0.1))
                              ]
                          ),
                          child: Icon(
                            Icons.check, // Use the correct icon based on selection
                            size: 13,
                            color: Colors.white, // Use the color based on selection
                          ),
                        ),
            
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                SubHeadingTextWidget(title: 'You have your own insurance that complies with local requirements. You understand that it is illegal to drive without liability insurance, and that you will be liable for any damage done to a 3rd party.',fontWeight: FontWeight.w500,fontSize: 13,),
                SizedBox(height: mq.height*.03,),
                HeadingTextWidget(title: 'Add custom coverage',fontSize: 16,textColor: AppColors.buttonColor,),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Extras section
                HeadingTextWidget(title: 'Extras',),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'Unlimited miles',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: '\$13.00 | day',fontSize: 14,)
                          ],
                        ),
                        Spacer(), // Add spacing between text and circle
                        Obx(
                              () => _switchButton(
                            controller.state.extraSwitchVal.value, (value) {
                            controller.state.extraSwitchVal.value = value;
                            controller.updateTotalPrice_Extras();
                          },
                          ),),
            
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                SubHeadingTextWidget(title: 'Your rental includes 1800 miles. You will pay \$0.45/mile thereafter.',fontWeight: FontWeight.w500,fontSize: 13),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Drivers
                HeadingTextWidget(title: 'Drivers',),
                SizedBox(height: mq.height*.02,),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blueGrey.withOpacity(.3),
                          child: Icon(Icons.person,color: Colors.black,),
                        ),
                        SizedBox(width: mq.width*.03,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingTextWidget(title: 'You',fontSize: 14,),
                            SizedBox(height: mq.height*.002,),
                            SubHeadingTextWidget(title: 'Not verified',fontSize: 14,textColor: Colors.red.withOpacity(.6),)
                          ],
                        ),
                      ],
                    ) ,
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                Row(
                  children: [
                    Obx(
                          () => Checkbox(
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey.withOpacity(.1),width: .5),
                        ),
                        visualDensity: VisualDensity.compact,
                        value: controller.state.driversCheckBoxVal.value,
                        onChanged: (bool? value) {
                          controller.state.driversCheckBoxVal.value = value!;
                          controller.updateTotalPrice_Drivers();
                        },
                      ),
                    ),
                    SizedBox(width: mq.width * 0.002),
                    SubHeadingTextWidget(title: 'I am under 25 years old', fontSize: 14),
                    SizedBox(width: mq.width * 0.02),
                    CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 8,
                      ),
                    )
                  ],
                ),
                SizedBox(height: mq.height*.01,),
                SubHeadingTextWidget(title: "Drivers License verification is required, you'll receive instructions after payment.",fontSize: 14,fontWeight: FontWeight.w500,),
                SizedBox(height: mq.height*.03,),
                SubHeadingTextWidget(title: 'Add additional driver fee of cost after bookings!',fontSize: 13,fontWeight: FontWeight.w500,),
                SizedBox(height: mq.height*.02,),
                GestureDetector(
                    onTap: (){
                      showCustomAlertDialog(context);
                    },
                    child: HeadingTextWidget(title: 'See Details',fontSize: 16,textColor: AppColors.buttonColor)),
                SizedBox(height: mq.height*.03,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Deposit policy section
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/card.jpeg'),height: mq.height*.05,width: mq.width*.05,),
                        SizedBox(width: 8),
                        HeadingTextWidget(title: 'Deposit policy')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                SubHeadingTextWidget(title: 'A temporary deposit of \$300.00(\$500.00 for debit cards)will be held on your card 24 hours before your trip starts. Typically, YbRide releases this deposit 3 days after your trip ends, but your bank may take an additional 5-10 business days for processing. Trips longer than 27 days will have the deposit captured and refunded after your trip',
                  fontSize: 15,fontWeight: FontWeight.w500,
                ),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Minimum age section
                HeadingTextWidget(title: 'Minimum age policy',),
                SizedBox(height: mq.height*.03,),
                HeadingTextWidget(title: 'Open minimum age policy',textColor: AppColors.buttonColor,fontWeight: FontWeight.w600,fontSize: 13,),
                SizedBox(height: mq.height*.03,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.03,),
                // cancellation policy
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(image: AssetImage('assets/images/signals.jpeg'),height: mq.height*.05,width: mq.width*.05,),
                        SizedBox(width: 8),
                        HeadingTextWidget(title: 'Cancellation policy')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: mq.height*.02,),
                SubHeadingTextWidget(title: "Free cancellation until 48h before start. By closing the booking, you confirm that you've read and accepted the trip information and the terms and conditions",
                  fontSize: 15,fontWeight: FontWeight.w500,
                ),
                SizedBox(height: mq.height*.03,),
                HeadingTextWidget(title: 'See terms and conditions',textColor: AppColors.buttonColor,fontWeight: FontWeight.w600,fontSize: 14,),
                SizedBox(height: mq.height*.02,),
                Divider(color: Colors.black54,thickness: .2,),
                SizedBox(height: mq.height*.02,),
                // Payment method section
                HeadingTextWidget(title: 'Payment method',),
                SizedBox(height: mq.height*.03,),
                GestureDetector(
                    onTap: (){
                      Get.to(()=>CreditCardScreen());
                    },
                    child: HeadingTextWidget(title: 'Add payment method',textColor: AppColors.buttonColor,fontWeight: FontWeight.w600,fontSize: 14,)),
                SizedBox(height: mq.height*.03,),
                GestureDetector(
                    onTap: (){
                      promoCodeBottomSheet(
                          context
                      );
                    },
                    child: HeadingTextWidget(title: 'Add promo code',textColor: AppColors.buttonColor,fontWeight: FontWeight.w600,fontSize: 14,)),
                SizedBox(height: mq.height*.03,),
                SizedBox(height:mq.height*.05,),
            
            
                    ],
                  ),
          ) ,
          Positioned(
              bottom: mq.height*0,
              left: mq.width*0,
              right: mq.width*0,
              child: Container(
                height: mq.height*.14, // Adjust the height based on your design
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade100)
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: mq.height*.01,horizontal: mq.width*.05),
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
                                                HeadingTextWidget(title: 'Total price',fontSize: 15,),
                                                SizedBox(width: mq.width * 0.02),
                                                CircleAvatar(
                                                  radius: 8,
                                                  backgroundColor: Colors.black,
                                                  child: Icon(
                                                    Icons.question_mark,
                                                    color: Colors.white,
                                                    size: 8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Obx(() =>
                                                SubHeadingTextWidget(title: '\$${controller.state.totalPrice.toStringAsFixed(2)}',fontSize: 13,),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                      SizedBox(width: mq.width * 0.06),
                      Padding(
                        padding:  EdgeInsets.only(bottom: mq.height*.017),
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
                              child: HeadingTextWidget(title: 'Add personal data',fontSize: 14,textColor: Colors.white,)
                          ),
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

Widget _switchButton(
    bool val, ValueChanged<bool>? onChanged) {
  return Switch(
     inactiveThumbColor: Colors.black54,
    inactiveTrackColor: Colors.transparent,
    activeColor: AppColors.whiteColor,
    activeTrackColor: AppColors.buttonColor,
    value: val,
    onChanged:  (value) {
      onChanged?.call(value);
      // AppSettings.openAppSettings();

    },
  );



}

