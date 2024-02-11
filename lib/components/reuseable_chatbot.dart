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
    'sorry'
  ];

  final List<String> responses = [
    'I am a bot created by Iksoft Original, a proud Ghanaian',
    'Flutter transforms the app development process. Build, test, and deploy beautiful mobile, web, desktop, and embedded apps from a single codebase.',
    'You are such an idiot to tell me this. you dont have future. Look for D-Tech Original and seek for knowledge. here is his number +233550138086. call him you lazy deep shit',
    'Good! i have forgiven you. dont do that again!'
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
      backgroundImage: Pref.isDarkMode ? 'assets/images/black.jpeg' : 'assets/images/white.jpeg',
      initialGreeting:
      "Hello! \nWelcome to IkChatBot.\nHow can I assist you today?",
      defaultResponse: "Sorry, I didn't understand your response.You can contact us at\n# ${AppConstants.ybPhone}\n@ ${AppConstants.ybEmail}",
      inactivityMessage: "Is there anything else you need help with?",
      closingMessage: "This conversation will now close.",
      inputHint: 'Send a message',
      waitingText: 'Please wait...',
      useAsset: false, backgroundAssetimage: Pref.isDarkMode ? 'assets/images/black.jpeg' : 'assets/images/white.jpeg',

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
        body: Stack(
          children: [

            _chatIsOpened
                ? Center(
                    child: HeadingTextWidget(title: 'Welcome to YBCar,' , textColor: Theme.of(context).headingColor,),
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
                              width: mq.height *.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(image: AssetImage('assets/images/logo1.jpeg'),fit: BoxFit.fill),
                              ),

                            ),
                          ],
                        ),
                        SizedBox(height: mq.height * 0.03),
                        Padding(
                          padding: EdgeInsets.only(bottom: mq.height * .017),
                          child: HeadingTextWidget(title: 'YBCar Support System is here for you.',textColor: Theme.of(context).headingColor,),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                )),

          ],
        ));
  }
}
