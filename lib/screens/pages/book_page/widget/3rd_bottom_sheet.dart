import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/icon_container.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/helper/app_colors.dart';
import 'package:yb_ride/helper/app_constants.dart';
import 'package:yb_ride/helper/app_helpers.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';
import 'package:yb_ride/screens/pages/book_page/widget/serach_text_field.dart';
import 'package:http/http.dart' as http;

import '../../../../main.dart';

Future returnBottomSheet(BuildContext context, BookViewController cont) {
  cont.state.uuid = Uuid();
  cont.state.locationSearchController.addListener(() {
    if (cont.state.sessionToken == null) {
      cont.state.sessionToken = cont.state.uuid!.v4();
    }
    cont.getSuggestions(
        cont.state.locationSearchController.text.trim().toString(),
        cont.state.sessionToken,
        cont);
  });

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Theme.of(context).scaffoldBgClr,
    builder: (BuildContext context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0,
                  -3), // Offset in the negative y-axis to create a top shadow
            ),
          ],
          color: Theme.of(context).scaffoldBgClr,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.horizontal_rule,
                  size: 40,
                  color: Theme.of(context).lightTextColor,
                ),
              ],
            ),
            Container(
              height: mq.height * 0.07,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: mq.width * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            // width: mq.width * 0.2,
                            child: IconContainer(iconName: 'XMark.png',height: 15,width: 15,),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: mq.width*0.1,),
                  HeadingTextWidget(
                    title: 'Return location',
                    fontWeight: FontWeight.w600,
                    fontSize: 19,
                    textColor: Theme.of(context).headingColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
              child: Divider(),
            ),
            SearchTextField(context, cont),
            Obx(() {
              return cont.state.placeList.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: mq.height * 0.01),
                          HeadingTextWidget(
                            title: 'No result found (yet)',
                            fontWeight: FontWeight.w600,
                            textColor: Theme.of(context).headingColor,
                          ),
                          SubHeadingTextWidget(
                            title:
                                "Try to adding more details, like 123 Main Street Black Bay Boston",
                            textColor: Theme.of(context).lightTextColor,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: mq.height * 0.01, horizontal: 20),
                            child: Divider(),
                          ),
                          SubHeadingTextWidget(
                            title: 'Add a city for better results',
                            textColor: Theme.of(context).lightTextColor,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: cont.state.searchLoading.value
                          ? Container()
                          : ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: cont.state.placeList.length,
                              itemBuilder: (context, index) {
                                return cont.state.placeList.length == 0
                                    ? Container()
                                    : ListTile(
                                        title: Text(cont.state
                                            .placeList[index]['description']
                                            .toString()),
                                        subtitle: Text(cont
                                            .state
                                            .placeList[index]
                                                ['structured_formatting']
                                                ['secondary_text']
                                            .toString()),
                                        onTap: () {
                                          cont.state.returnPlace.value = cont
                                              .state
                                              .placeList[index]['description']
                                              .toString();

                                          cont.GetCoordinatesofReturn(context);

                                          if (cont.state.switchVal.value ==
                                              false) {
                                            if (cont.state.selectedPlace
                                                        .value !=
                                                    "Tap to Search" &&
                                                cont.state.returnPlace.value !=
                                                    "Return Place") {
                                              cont.state.locationSelected
                                                  .value = true;
                                            }
                                          }

                                          cont.state.locationSearchController
                                              .clear();
                                          // cont.state.placeList.clear();
                                          cont.state.placeList.value = [];
                                          Navigator.pop(context);
                                        },
                                      );
                              }),
                    );
            }),
          ],
        ),
      );
    },
  );
}

// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:uuid/uuid.dart';
// import 'package:yb_ride/components/heading_text_widget.dart';
// import 'package:yb_ride/components/reuseable_button.dart';
// import 'package:yb_ride/components/snackbar_widget.dart';
// import 'package:yb_ride/components/text_form_field.dart';
// import 'package:yb_ride/components/text_widget.dart';
// import 'package:yb_ride/helper/app_colors.dart';
// import 'package:yb_ride/helper/app_constants.dart';
// import 'package:yb_ride/helper/app_helpers.dart';
// import 'package:yb_ride/screens/pages/book_page/controller.dart';
// import 'package:yb_ride/screens/pages/book_page/widget/serach_text_field.dart';
// import 'package:http/http.dart' as http;
//
// import '../../../../main.dart';
//
// Future returnBottomSheet(BuildContext context, BookViewController cont) {
//   cont.state.uuid = Uuid();
//   cont.state.locationSearchController.addListener(() {
//     if (cont.state.sessionToken == null) {
//       cont.state.sessionToken = cont.state.uuid!.v4();
//     }
//     cont.getSuggestions(
//         cont.state.locationSearchController.text.trim().toString(),
//         cont.state.sessionToken,
//         cont);
//   });
//
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     useSafeArea: true,
//     backgroundColor: Theme.of(context).scaffoldBgClr,
//     builder: (BuildContext context) {
//       return Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5), // Shadow color
//               spreadRadius: 1, // Spread radius
//               blurRadius: 5, // Blur radius
//               offset: Offset(0,
//                   -3), // Offset in the negative y-axis to create a top shadow
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.horizontal_rule,
//                   size: 40,
//                   color: Theme.of(context).lightTextColor,
//                 ),
//               ],
//             ),
//             Container(
//               height: mq.height * 0.07,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: mq.width * 0.1,
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           width: mq.width * 0.2,
//                           child: FaIcon(FontAwesomeIcons.xmark,
//                               size: 23, color: Theme.of(context).headingColor),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Flexible(
//                     child: HeadingTextWidget(
//                       title: 'Return location',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 19,
//                       textColor: Theme.of(context).headingColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
//               child: Divider(),
//             ),
//             SearchTextField(context, cont),
//             Obx(() {
//               return cont.state.placeList.length == 0
//                   ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     SizedBox(height: mq.height * 0.01),
//                     HeadingTextWidget(title: 'No result found (yet)',fontWeight: FontWeight.w600,textColor: Theme.of(context).headingColor,),
//                     SubHeadingTextWidget(title: "Try to adding more details, like 123 Main Street Black Bay Boston",
//                       textColor: Theme.of(context).lightTextColor,
//                       textAlign: TextAlign.center,),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           vertical: mq.height * 0.01, horizontal: 20),
//                       child: Divider(),
//                     ),
//                     SubHeadingTextWidget(
//                       title: 'Add a city for better results',
//                       textColor: Theme.of(context).lightTextColor,
//                     ),
//                   ],
//                 ),
//               )
//                   : Expanded(
//                 child: cont.state.searchLoading.value
//                     ? Container()
//                     : ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     itemCount: cont.state.placeList.length,
//                     itemBuilder: (context, index) {
//                       return cont.state.placeList.length == 0
//                           ? Container()
//                           : ListTile(
//                         title: Text(cont.state
//                             .placeList[index]['description']
//                             .toString()),
//                         subtitle: Text(cont
//                             .state
//                             .placeList[index]
//                         ['structured_formatting']
//                         ['secondary_text']
//                             .toString()),
//                         onTap: () {
//                           cont.state.returnPlace.value = cont
//                               .state
//                               .placeList[index]['description']
//                               .toString();
//
//                           if(cont.state.switchVal.value == false){
//                             if(cont.state.selectedPlace.value != "Tap to Search"
//                                 && cont.state.returnPlace.value != "Return Place"
//                             ){
//                               cont.state.locationSelected.value = true;
//                             }
//                           }
//                           cont.GetCoordinatesofReturn();
//                           cont.state.locationSearchController
//                               .clear();
//                           cont.state.placeList.clear();
//                           Navigator.pop(context);
//                           // Navigator.pop(context);
//                         },
//                       );
//                     }),
//               );
//             }),
//           ],
//         ),
//       );
//     },
//   );
// }
