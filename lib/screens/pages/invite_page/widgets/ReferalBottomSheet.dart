import 'package:flutter/material.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_widget.dart';

Future<void> ReferalBottoSheet(BuildContext context) async {
  showModalBottomSheet(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              // color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(child: HeadingTextWidget(title: 'Invite Friends ')),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: SubHeadingTextWidget(
                      title:
                          'Invite your firends and you will get \$30 discount on your checkout',
                      maxLines: 4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      child: Center(
                        child: Padding(
                          padding:  EdgeInsets.symmetric(vertical: 10),
                          child: SubHeadingTextWidget(
                            title: 'AZXC345',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                    title: 'Send Invitation',
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
