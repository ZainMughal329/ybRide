


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';

import '../../../components/custom_Appbar.dart';
import '../../../main.dart';

class CheckOutScreen extends GetView<CheckOutCon> {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(mq.height* .08), child:CustomAppBarWidget(centerTitle: 'Checkout',isLeading: true,) ),
      body:Stack(
        children: [
          ListView(
            padding:EdgeInsets.symmetric(vertical: mq.height*.03,horizontal: mq.width*.05),
            children: [
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
                          Icon(Icons.cancel,color: Colors.black,)
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
              ),
              SizedBox(height: mq.height*.03,),
              HeadingTextWidget(title: 'Have a promo code?',fontSize:18,),
              SizedBox(height: mq.height*.02,),
              Container(
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
              SizedBox(height: mq.height*.02,),
              Divider(color: Colors.black54,thickness: .2,),
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
                  Padding(
                      padding: EdgeInsets.only(right: mq.width*.65),
                      child: HeadingTextWidget(title: 'Change car',fontWeight: FontWeight.w600,fontSize: 14,textColor:AppColors.buttonColor,))
                
                  
                ],
              ),
              SizedBox(height: mq.height*.02,),
              Divider(color: Colors.black54,thickness: .2,),
              SizedBox(height: mq.height*.02,),
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
              HeadingTextWidget(title: 'View instructions',textColor: AppColors.buttonColor,fontSize: 15,),
              SizedBox(height: mq.height*.02,),
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
              HeadingTextWidget(title: 'Add custom coverage',fontSize: 16,),
              SizedBox(height: mq.height*.02,),
              Divider(color: Colors.black54,thickness: .2,),
              HeadingTextWidget(title: 'Extras',),
              SizedBox(height: 100,),

          // Padding(
          //   padding: const EdgeInsets.only(top: 0,bottom: 0,left: 40,right: 40),
          //   child: Container  (
          //     child: Column(
          //       children: [
          //         Expanded(child: Column(
          //           children: [
          //             Row(
          //               children: [
          //                 HeadingTextWidget(title: 'Total price'),
          //                 CircleAvatar(
          //                   backgroundColor: Colors.black,
          //                   child: Icon(
          //                     Icons.question_mark,
          //                     color: Colors.white,
          //                   ),
          //                 )
          //
          //               ],
          //             ),
          //             SubHeadingTextWidget(title: '\$#02.11')
          //           ],
          //         )
          //         ),
          //         Expanded(
          //           child: GestureDetector(
          //             onTap: (){
          //             },
          //             child: Container(
          //               height: 60,
          //               width: double.infinity,
          //               decoration: BoxDecoration(
          //                 color: AppColors.buttonColor.withOpacity(0.8),
          //                 borderRadius: BorderRadius.all(
          //                   Radius.circular(20),
          //                   // topRight: Radius.circular(10),
          //                 ),
          //               ),
          //               child: Center(
          //                 child: HeadingTextWidget(title: 'Add personal data')
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //
        ],
      ) ,
    ]));
  }
}
