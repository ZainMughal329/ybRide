import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/settings/pages/ybcar_surfer/inded.dart';


import '../../../../components/phone_number_input_field.dart';
import '../../../../main.dart';

class SurferScreen extends GetView<SurferController> {
  const SurferScreen({super.key});

  Widget _serviceList() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Service',
              style: GoogleFonts.openSans(fontSize: 17),
            ),
            DropdownButton(
                iconEnabledColor: AppColors.buttonColor,
                hint: Text(
                  controller.state.serviceOffering.value,
                  style: GoogleFonts.openSans(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    child: Text('Boston'),
                    value: 'Boston',
                  ),
                ],
                onChanged: (value) {
                  controller.state.serviceOffering.value = value.toString();
                }),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SurferController());
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: mq.height * .3,
                    width: double.infinity,
                    color: AppColors.buttonColor,
                    child:Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(FontAwesomeIcons.xmark)),
                            ),
                          ),
                          Spacer(),
                          SubHeadingTextWidget(
                            title: 'You are applying for:',
                            textColor: Colors.white60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          HeadingTextWidget(
                            title: 'YBCar Driver Partner',
                            textColor: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                          ),
                          Spacer(
                            flex: 2,
                          ),

                        ],
                      ),
                    ),



                  ),

                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadingTextWidget(
                          title: 'Description',
                          fontSize: 14,
                          textColor: Theme.of(context).headingColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor.withOpacity(.5),
                            border: Border.all(color: Theme.of(context).headingColor),
                            borderRadius: BorderRadius.all(Radius.circular(10),),
                          ),
                          child: Obx( () => controller.state.isCollapsed.value ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                HeadingTextWidget(
                                  title:
                                      'Rental Car Delivery Driver - Flexible Earning Opportunity!',
                                  textColor: Theme.of(context).headingColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                  title:
                                      'Kyte is looking for passionate people who want to join our Kyte "Surfer" team! You will be responsible for delivering and picking up rental cars from different locations in your city. ',
                                  textColor: Theme.of(context).lightTextColor,
                                  maxLines: controller.state.isCollapsed.value ? 3 : null,
                                  overflow: controller.state.isCollapsed.value
                                      ? TextOverflow.ellipsis
                                      : null,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                HeadingTextWidget(
                                  title: "Why you'll love working with Kyte:",
                                  textColor: Theme.of(context).headingColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "a : Earn more: Earn more than the industry average, plus 100% of tips and bonuses!",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "b : Be your own boss: Choose when you want to work! ",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "c : Easy to get started: No car needed!",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 15,
                                ),
                                HeadingTextWidget(
                                  title: "Requirements:",
                                  textColor: Theme.of(context).headingColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "a : Have a valid driver’s license and be legally authorized to work",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title: "b : Must be 21+ years old",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 15,
                                ),
                                HeadingTextWidget(
                                  title: "About the role:",
                                  textColor: Theme.of(context).headingColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "a : You'll interact with customers as the face of the company - we're looking for people who are comfortable with face to face interactions!",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "b : Be ready to flag any maintenance, scratches, tire damage on the vehicles before delivery and after returns.",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "c : Weekends are our busiest times - look out for potential weekend bonuses!",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                    title:
                                        "d : Bonus points for a cool, crafty mode of transportation that will get you from one delivery/return to the next! This could be a scooter, scooter app, foldable bike, electric skateboard... show us what you've got!",
                                    textColor:
                                        Theme.of(context).lightTextColor),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  children: [
                                    HeadingTextWidget(
                                      title: 'Job Type: ',
                                      textColor:
                                          Theme.of(context).headingColor,
                                    ),
                                    SubHeadingTextWidget(
                                        title: "Independent Contractor",
                                        textColor:
                                            Theme.of(context).lightTextColor),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    HeadingTextWidget(
                                      title: 'Salary: ',
                                      textColor:
                                          Theme.of(context).headingColor,
                                    ),
                                    SubHeadingTextWidget(
                                        title: "Task-based",
                                        textColor:
                                            Theme.of(context).lightTextColor),
                                  ],
                                ),
                              ],
                            ),
                          ) : Container(
                            child:
                            Column(
                              children: [
                                HeadingTextWidget(
                                  title:
                                  'Rental Car Delivery Driver - Flexible Earning Opportunity!',
                                  textColor: Theme.of(context).headingColor,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SubHeadingTextWidget(
                                  title:
                                  'Kyte is looking for passionate people who want to join our Kyte "Surfer" team! You will be....  ',
                                  textColor: Theme.of(context).lightTextColor,
                                  maxLines: controller.state.isCollapsed.value ? 3 : null,
                                  overflow: controller.state.isCollapsed.value
                                      ? TextOverflow.ellipsis
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    ()=> Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 50,
                        width: 130,
                        decoration: BoxDecoration(
                          color: AppColors.buttonColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.toggleCollapsed();
                          },
                          child: Center(
                            child: SubHeadingTextWidget(
                              title: controller.state.isCollapsed.value ? 'Collapse Content' : 'Continue Reading',
                              textAlign: TextAlign.center,
                              textColor: AppColors.buttonTextColor,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: HeadingTextWidget(
                      title: 'FIRST NAME ',
                      textColor: Theme.of(context).headingColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ReuseableTextField(
                      contr: controller.state.fNameCon,
                      label: 'First Name',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obsecure: false),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: HeadingTextWidget(
                        title: 'LAST NAME ',
                        textColor: Theme.of(context).headingColor,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  ReuseableTextField(
                      contr: controller.state.lNameCon,
                      label: 'Last Name',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obsecure: false),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: HeadingTextWidget(
                        title: 'EMAIL ',
                        textColor: Theme.of(context).headingColor,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  ReuseableTextField(
                      contr: controller.state.emailCon,
                      label: 'Email',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obsecure: false),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: HeadingTextWidget(
                        title: 'PHONE NUMBER ',
                        textColor: Theme.of(context).headingColor,
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => PhoneNumberField(
                        controller.state.code.value,
                        () async {
                          final code = await controller.state.countryPicker
                              .showPicker(context: context);
                          // Null check
                          if (code != null) {
                            controller.state.code.value = code;
                          }
                          ;
                        },
                        controller.state.phoneNumberCon,
                        controller.state.focused.value,
                        () {
                          controller.state.focused.value =
                              !controller.state.focused.value;
                        },
                        context),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: HeadingTextWidget(
                      title: 'WHAT CITY WILL YOU BE SURFING IN? ',
                      textColor: Theme.of(context).headingColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _serviceList(),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SubHeadingTextWidget(
                      title:
                          'By providing us with your phone number and clicking "Submit", you agree that we may call or text you regarding your application. Message & data rates may apply.',
                      textColor: Theme.of(context).lightTextColor,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  RoundButton(
                    title: 'Submit',
                    onPress: () {},
                  ),
                ],
              ),
              Positioned(
                top: 180,
                left: mq.width/2.5,
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: mq.height * .09,
                    width: mq.height * .09,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(image: AssetImage('assets/whiteIcons/WhiteLogo.png',),)
                    ),
                    // child: Image.asset('assets/images/logo1.jpeg' , fit: BoxFit.contain,),
                    // color: AppColors.orangeColor,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
