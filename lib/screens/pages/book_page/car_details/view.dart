import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/inded.dart';
import 'package:yb_ride/screens/pages/book_page/car_details/widgets/details_sheet.dart';
import 'package:yb_ride/screens/splash/controller.dart';

import '../../../../main.dart';
import '../controller.dart';
import '../widget/1st_bottom_sheet.dart';

class CarDetailsScreen extends GetView<CarDetailsController> {
  const CarDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(mq.height * .08),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context)
                .appBarColor, // Set your preferred background color
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Set shadow color
                blurRadius: 4, // Set the blur radius for the 3D effect
                offset: Offset(0, 2), // Set the offset for the shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                InkWell(
                  onTap: (){
                    print('pressed');
                    final cont = Get.put(BookViewController());
                    firstBottomSheet(context, cont);
                  },
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Column(
                            children: [
                              Text(
                                'Boston',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: AppColors.buttonColor,
                                ),
                              ),
                              Text(
                                'Jan 19 - Jan 25',
                                style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.buttonColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Icon(
                              Icons.arrow_drop_down,
                              size: 18,
                            color: AppColors.buttonColor,

                            ),

                        ),
                      ],
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: 10,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(mq.height * .035),
                  child: _buildCARCard(context),
                );
              })),
    );
  }

  Widget _buildCARCard(BuildContext context) {
    return Container(
      height: mq.height * .34,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: mq.height * .23,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.red,
              border: Border.all(
                color: Colors.black12
              ),
            ),
            child: Swiper(

              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  controller.imagesList[index],
                  fit: BoxFit.cover,
                  // height: 188.h,
                  width: mq.width *.288,
                );
              },
              autoplay: false,
              itemCount: controller.imagesList.length,
              viewportFraction: 0.8,
              scale: 0.9,
              pagination: SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                    color: Colors.black12,
                    activeColor: Colors.white,
                    activeSize: 13),
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadingTextWidget(
                title: 'Economy',
                textColor: Theme.of(context).headingColor,
              ),
              InkWell(
                onTap: (){
                  final cont = Get.put(BookViewController());

                  detailsBottomSheet(context);

                },
                child: SubHeadingTextWidget(
                  title: 'See details',
                  textColor: AppColors.buttonColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubHeadingTextWidget(
                    title: 'Nissan Versa or similar',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SubHeadingTextWidget(
                    title: '5 seats . 1 suitcase',
                    textColor: Theme.of(context).lightTextColor,
                  ),
                ],
              ),
              HeadingTextWidget(
                title: '\$23.99 | day',
                textColor: Theme.of(context).headingColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
