import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/application/inded.dart';
import 'package:yb_ride/screens/pages/book_page/widget/1st_bottom_sheet.dart';
import 'package:yb_ride/screens/pages/book_page/controller.dart';

class BookNowView extends StatelessWidget {
  BookNowView({Key? key}) : super(key: key);
  final cont = Get.put(BookViewController());


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    cont.state.datesFetched==false ? cont.getCurrentDate() : null;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      body: Stack(
        children: [
          GetBuilder<BookViewController>(builder: (controller){
            return GoogleMap(
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              markers: controller.markers,
              onMapCreated: (con) {
                cont.state.mapController = con;
                // await firstBottomSheet(context, cont);
                controller.updateMapTheme(controller.state.mapController!);

              },
              initialCameraPosition: CameraPosition(
                target: cont.state.loc.value,
                zoom: 12,
              ),

            );
          }),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: mq.height * 0.10,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mq.height * 0.005,
                          horizontal: mq.width * 0.005,
                        ),
                        child: RoundButton(
                          title: 'Start Searching',
                          onPress: () {
                            firstBottomSheet(context,cont);
                           // try{
                           //   Snackbar.showSnackBar("Ybride", "msg", Icons.error_outline_rounded);
                           // }catch(e){
                           //   print("Exception is$e");
                           // }

                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
