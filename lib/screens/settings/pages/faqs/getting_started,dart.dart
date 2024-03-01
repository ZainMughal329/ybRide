import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/main.dart';

import '../../../../components/faq_item.dart';
import '../../../../helper/app_colors.dart';


Future gettingStartedSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Container(
            height: mq.height * .17,
            decoration: BoxDecoration(
              color: AppColors.buttonColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mq.height * .02, vertical: mq.height * .02),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new,
                        size: 12,
                      ),
                      HeadingTextWidget(
                        title: 'Help',
                        textColor: Colors.white,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // controller: ,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                    ),

                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(.3),
                      isDense: true,
                      hintText: 'Search for help',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      hintStyle: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(16.0),
            physics: BouncingScrollPhysics(),
            children: [
              FAQItem(
                question: 'How does YBCar work?',
                answer:
                    "Book a car from our new and clean fleet.\nTell us where you want to get the car and choose a good time to meet.\nYBCar Buddy\'s can deliver your vehicle and pick it up when you’re done. If it’s more convenient, you can pick it up yourself at one of our lots.\nIf you chose delivery, a YBCar Buddy will pick up the car at the return address you selected. Otherwise, you can return the car to one of our lots.\nIt's that easy, no lines, no paperwork, just rental cars, your way.",
              ),
              Divider(),
              FAQItem(
                question: 'Where is YBCar available?',
                answer: "We're currently operating in the following cities:"
                    "a:Boston",
              ),
              Divider(),

              FAQItem(
                question:
                    "What are the mileage limits? Can I purchase unlimited mileage?",
                answer:
                    "At YBCar, we include 300 miles per day for all our trips, which are cumulative throughout the booking period. So, if you book for 3 days, you will have a total of 900 miles for free that you can use during your trip. However, if you exceed the mileage limit, we will charge a surcharge of \$0.45 per mile."
                    "If you want to add unlimited mileage to your trip, you can easily do so through our website or app during the checkout process. In case you have already booked your trip and want to add unlimited mileage later, just reach out to us before your trip starts, and we will add it for you.",
              ),
              Divider(),

              FAQItem(
                question: 'Can I take my YBCar into Canada or Mexico?',
                answer:
                    "Unfortunately, our cars can't travel into Canada or Mexico."
                    "If for any reason your YBCar is detained in either Canada or Mexico, you'll be fully liable for any costs associated with the retrieval of the car up to the full cost of the car.",
              ),
              Divider(),

              FAQItem(
                question: 'Can I bring pets on my YBCar trip?',
                answer:
                    'Absolutely, your furry friends are welcome. We suggest using a carrier or seat cover if you have an extra fluffy copilot.',
              ),
              Divider(),

              // Add more FAQ items as needed
            ],
          ),
        ],
      );
    },
  );
}
