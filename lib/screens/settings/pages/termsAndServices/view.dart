import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:yb_ride/components/custom_Appbar.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:flutter_quill/flutter_quill.dart';
import '../../../../api/api.dart';
import '../../../../main.dart';

class TermsAndServices extends StatelessWidget {
  TermsAndServices({super.key});

  QuillController controller = QuillController.basic(

  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      appBar: CustomAppBarWidget(
        centerTitle: 'Terms And Services',
        isLeading: true,
        leadingPress: () {
          Navigator.pop(context);
        },
        leadingIcon: Icons.arrow_back,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                // height: double.infinity,
                width: mq.width * .9,
                decoration: BoxDecoration(
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
                child: StreamBuilder<QuerySnapshot>(
                    stream: APis.db.collection('termsAndConditions').snapshots(),
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
                      var data = snapshot.data!.docs.first;
                      var fromDateString =
                      data['dateTime']
                      as String;
                      log('terms and services:$fromDateString');
                      var fromDateMillis =
                      int.parse(fromDateString);
                      var fromDate = DateTime
                          .fromMillisecondsSinceEpoch(
                          fromDateMillis);
                      var fromFormattedDate =
                      DateFormat.yMd().format(
                          fromDate.toLocal());

                      controller.document = Document.fromJson(jsonDecode(data['termsAndConditions']));
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.0 , left: 10),
                            child: SubHeadingTextWidget(title: 'Updated on : ' + fromFormattedDate , textColor: Theme.of(context).headingColor,fontWeight: FontWeight.normal,fontSize: 13,),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                            child: QuillEditor.basic(

                              configurations: QuillEditorConfigurations(

                                controller: controller,

                                readOnly: true,
                                sharedConfigurations: const QuillSharedConfigurations(
                                  locale: Locale('en'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
