import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/shared_pref.dart';
import 'package:yb_ride/routes/app_routes.dart';
import 'package:yb_ride/routes/routes_name.dart';
import '../../components/heading_text_widget.dart';
import '../../components/reuseable_button.dart';
import '../../components/text_widget.dart';
import '../../main.dart';
import 'controller.dart';

class OnBoardingScreen extends GetView<OnBoardingController> {
  final bool isOnboarding;

  const OnBoardingScreen({required this.isOnboarding, super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingController controller =
        Get.put<OnBoardingController>(OnBoardingController());



    final c = PageController();
    final list = [
      onBoard(
          title: 'Rental cars delivered to your door',
          subtittle: 'The easiest way to rent a car',
          image: 'logo1.jpeg'),
      onBoard(
          title: 'Tell us where and when',
          subtittle:
              'Reserve a new, clean car and a driver will bring it to your, whenever you need it.',
          image: '2.png'),
      onBoard(
          title: 'We deliver car with love',
          subtittle:
              "Let's face it... Picking up a rental car is painful so don't do it, Reserve a ybride, a driver will bring it to you, on demand",
          image: '4.jpeg'),

      onBoard(
          title: 'We fuel up for you',
          subtittle:
          "It's your adventure! No need to refuel your car before you return it. We'll fuel up for you at transparent rates! No hidden fees. ",
          image: '7.png'),
      onBoard(
          title: 'We pick up YBCars',
          subtittle:
              "When you're done! A driver\n will pick up the car from a location of your choice",
          image: '3.png'),
    ];
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      body: PageView.builder(
        controller: c,
          itemCount: list.length,
          itemBuilder: (ctx, ind) {
            final isLast = ind == list.length - 1;
            return Stack(
              children: [
                Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: mq.height * .09),
                      child: Image(
                          image: AssetImage(
                              'assets/images/${list[ind].image}'),
                          height: mq.height * .3,
                          width: mq.width * .5),
                    ),
                    Center(
                      child: SizedBox(
                        width: mq.width * .9,
                        child: HeadingTextWidget(
                          fontSize: ind == 0 ? 23 : 20,
                          textAlign: TextAlign.center,
                          title: list[ind].title,
                            textColor: AppColors.headingColor
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .02,
                    ),
                    Center(
                      child: SizedBox(
                          width: mq.width * .8,
                          child: SubHeadingTextWidget(
                            textAlign: TextAlign.center,
                            title: list[ind].subtittle,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.textColor,
                            fontSize: 14,
                            maxLines: ind == 3 ? null : 3,
                            overflow: ind == 3
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          )),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: mq.height * .06,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Wrap(
                      spacing: 5,
                      children: List.generate(
                          list.length,
                          (i) => Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: i == ind
                                        ? AppColors.buttonColor
                                        : Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                    ),
                    SizedBox(
                      height: mq.height * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: mq.width * .02, right: mq.width * .02),
                      child: RoundButton(
                        title: isLast ? 'Finish' : 'Next',
                        onPress: isOnboarding
                            ? () {
                                if (isLast) {
                                  Pref().setIsFirstOpen(true);
                                  Get.offNamed(RoutesName.welcomeScreen);
                                } else {
                                  c.nextPage(
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.ease);
                                }
                              }
                            : () {
                                Get.back();
                              },
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .04,
                    ),
                  ],
                ),
                isOnboarding
                    ? SizedBox()
                    : Positioned(
                        top: 20,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: FaIcon(FontAwesomeIcons.xmark),
                        ),
                      ),
              ],
            );
          }),
    );
  }
}

class onBoard {
  final String title, subtittle;
  final String image;

  onBoard({required this.title, required this.subtittle, required this.image});
}
