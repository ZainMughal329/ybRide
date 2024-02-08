import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/main.dart';

import '../../../../../components/custom_Appbar.dart';
import '../../../../../helper/app_colors.dart';

class ShowFAQs extends StatelessWidget {
  final String collectionName;
  final String appBarTitle;

  const ShowFAQs(
      {super.key, required this.collectionName, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        centerTitle: appBarTitle,
        isLeading: true,
        leadingIcon: Icons.arrow_back,
        leadingPress: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              height: mq.height * 1,

              width: mq.width * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).scaffoldBgClr,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).headingColor.withOpacity(.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(1, 1),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: APis.db.collection(collectionName).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: Lottie.asset('assets/lottie/loading2.json'),
                          ),
                        );
                      }
                      var data = snapshot.data!.docs;
                      return data.length != 0
                          ? Expanded(
                            child: ListView.builder(
                                                  // shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: mq.width * .9,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.buttonColor,
                                          width: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        color: Theme.of(context).scaffoldBgClr,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Theme.of(context).headingColor.withOpacity(.1),
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: ExpansionTile(
                                          title:
                                          HeadingTextWidget(title:data[index]['question'],textColor: Theme.of(context).headingColor,fontSize: 16,fontWeight: FontWeight.w600,),
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                child: HeadingTextWidget(title:data[index]['answer'],textColor: Theme.of(context).lightTextColor,fontSize: 12,fontWeight: FontWeight.normal,),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                          : Column(
                            children: [
                              Align(
                                                      alignment: Alignment.bottomCenter,
                                child: HeadingTextWidget(
                                  title: 'No articles here yet.',
                                  textColor: Theme.of(context).headingColor,
                                ),
                              ),

                            ],
                          );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
