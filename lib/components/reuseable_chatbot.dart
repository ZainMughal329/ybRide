import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ikchatbot/ikchatbot.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/prefs.dart';
import 'package:yb_ride/main.dart';

import '../helper/app_colors.dart';
import 'custom_Appbar.dart';

class ReUseAbleChatBot extends StatelessWidget {
  // This widget is the root of your application.

  final List<String> keywords = [
    'who are you',
    'what is flutter',
    'fuck',
    'sorry',
    'account login',
    'profile update',
    'preferences',
    'dark mode',
    'light mode',
    'privacy policy',
    'car availability',
    'car selection',
    'rental duration',
    'rental cost',
    'booking confirmation',
    'trip details',
    'trip cancellation',
    'customer support',
    'help',
    'contact information',
    'payment confirmation',
    'invoice details',
    'driver application',
    'driver requirements',
    'invite friends',
    'earn rewards',
    'refer a friend',
    'promo code',
  ];

  final List<String> responses = [
    'I am a bot created by Dev-Tech Originals',
    'Flutter transforms the app development process. Build, test, and deploy beautiful mobile, web, desktop, and embedded apps from a single codebase.',
    'You are such an idiot to tell me this. you dont have future. Look for D-Tech Original and seek for knowledge. here is his number +233550138086. call him you lazy deep shit',
    'Good! i have forgiven you. dont do that again!',
    'To access your YB-Ride account, enter your registered email and password on the login screen. Click on the Logi button to proceed.',
    'Update your profile information such as name, email, phone number from the profile settings. Click on the Profile option to make changes.',
    'Customize your YB-Ride experience by setting preferences such as notification preferences, language preferences, and vehicle preferences.',
    'Switch to dark mode for a darker color scheme that is easier on the eyes, especially in low-light environments. Toggle dark mode on/off from the app settings.',
    'Switch back to light mode for a brighter color scheme. Toggle light mode on/off from the app settings.',
    'Read our privacy policy to understand how we collect, use, and protect your personal information. You can find our privacy policy in the app settings.',
    'Check the availability of rental cars for your desired location, date, and time. Browse through available cars and select the one that meets your needs.',
    'Choose from a variety of car types including economy, all-wheel drive, SUV, and sedan. Select the car that best suits your preferences and requirements.',
    'Select the rental duration by specifying the pickup date and time, as well as the drop-off date and time. The rental duration determines the total cost of your rental.',
    'The rental cost depends on factors such as the car type, rental duration, additional services (protection coverage, delivery/pickup options), and any applicable taxes or fees.',
    'Upon successful booking, you will receive a confirmation email with your booking details including car type, rental duration, pickup/drop-off location, and total cost.',
    'View your trip details including car type, pickup/drop-off location, rental duration, and total cost from the Trip Details section in the app',
    'You can cancel your trip by contacting the YB-Ride support at ${AppConstants.ybEmail} or by phone at ${AppConstants.ybPhone}. Please note that cancellation fees may apply.',
    'For assistance or inquiries, contact our customer support team. You can reach us via email at ${AppConstants.ybEmail} or by phone at ${AppConstants.ybPhone}.',
    'Access help resources, FAQs, and troubleshooting guides from the Help section in the app. Find answers to common questions and get assistance with app-related issues.',
    'For assistance or inquiries, contact our customer support team. You can reach us via email at ${AppConstants.ybEmail} or by phone at ${AppConstants.ybPhone}.',
    'After successful payment, you will receive a payment confirmation email containing details of your transaction.',
    'You can view and download your invoice details from the gallery of your mobile. Invoices include a breakdown of charges for your rental, taxes, fees, and any applicable discounts.',
    'Interested in becoming a YB-Buddy driver? You can apply to become a driver by filling out the driver application form on our application and website. Once submitted, our team will review your application.',
    'To qualify as a YB-Buddy driver, you must meet certain requirements including a valid driving license, clean driving record, background check, and vehicle eligibility. Additional requirements may apply based on your location.',
    'Invite your friends to join YB-Ride and earn rewards! Share your unique referral code with friends, and when they sign up using your code you will receive reward.',
    'Invite your friends to join YB-Ride and earn rewards! Share your unique referral code with friends, and when they sign up using your code you will receive reward.',
    'Invite your friends to join YB-Ride and earn rewards! Share your unique referral code with friends, and when they sign up using your code you will receive reward.',
    'Apply the promo code during checkout to get discounts on your trips',
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    final chatBotConfig = IkChatBotConfig(
      //SMTP Rating to your mail Settings
      ratingIconYes: const Icon(Icons.star),
      ratingIconNo: const Icon(Icons.star_border),
      ratingIconColor: Colors.black,

      ratingBackgroundColor: Colors.white,
      ratingButtonText: 'Submit Rating',
      thankyouText: 'Thanks for your rating!',
      ratingText: 'Rate your experience:',
      ratingTitle: 'Thank you for using the chatbot!',
      body: 'This is a test email sent from Flutter and Dart.',
      subject: 'Test Rating',
      recipient: '',
      isSecure: false,
      senderName: 'Your Name',
      smtpUsername: 'Your Email',
      smtpPassword: 'your password',
      smtpServer: 'stmp.gmail.com',
      smtpPort: 587,
      //Settings to your system Configurations
      sendIcon: const Icon(Icons.send, color: Colors.black),
      userIcon: const Icon(Icons.animation, color: Colors.white),
      botIcon: const Icon(Icons.android, color: Colors.white),
      botChatColor: Color.fromARGB(255, 104, 0, 101),
      delayBot: 100,
      closingTime: 50,
      delayResponse: 1,
      userChatColor: const Color.fromARGB(255, 103, 0, 0),
      waitingTime: 1,
      keywords: keywords,
      responses: responses,
      backgroundColor: Theme.of(context).scaffoldBgClr,
      backgroundImage: Pref.isDarkMode
          ? 'assets/images/black.jpeg'
          : 'assets/images/white.jpeg',
      initialGreeting:
          "Hello! \nWelcome to IkChatBot.\nHow can I assist you today?",
      defaultResponse:
          "Sorry, I didn't understand your response.You can contact us at\n# ${AppConstants.ybPhone}\n@ ${AppConstants.ybEmail}",
      inactivityMessage: "Is there anything else you need help with?",
      closingMessage: "This conversation will now close.",
      inputHint: 'Send a message',
      waitingText: 'Please wait...',
      useAsset: false,
      backgroundAssetimage: Pref.isDarkMode
          ? 'assets/images/black.jpeg'
          : 'assets/images/white.jpeg',
    );

    return MyHomePage(chatBotConfig: chatBotConfig);
  }
}

class MyHomePage extends StatelessWidget {
  final IkChatBotConfig chatBotConfig;

  const MyHomePage({Key? key, required this.chatBotConfig}) : super(key: key);

  final bool _chatIsOpened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBgClr,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mq.height * .08),
          child: CustomAppBarWidget(
            centerTitle: 'Customer Support YBCar',
            isLeading: true,
            leadingIcon: Icons.arrow_back_ios_new,
            leadingPress: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: Padding(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom),
          child: Stack(
            children: [
              _chatIsOpened

                  ? Center(
                      child: HeadingTextWidget(
                        title: 'Welcome to YBCar,',
                        textColor: Theme.of(context).headingColor,
                      ),
                    )
                  : ikchatbot(config: chatBotConfig),

              Positioned(
                  top: mq.height * 0,
                  left: mq.width * 0,
                  right: mq.width * 0,
                  child: Container(
                    height: mq.height * .24,
                    // Adjust the height based on your design
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBgClr,
                      // color: Colors.red,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: mq.height * .01, horizontal: mq.width * .05),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: mq.height * .1,
                                width: mq.height * .1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/logo1.jpeg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: mq.height * 0.03),
                          Padding(
                            padding: EdgeInsets.only(bottom: mq.height * .017),
                            child: HeadingTextWidget(
                              title: 'YBCar Support System is here for you.',
                              textColor: Theme.of(context).headingColor,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
