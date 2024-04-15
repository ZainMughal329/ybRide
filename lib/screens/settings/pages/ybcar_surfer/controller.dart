import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/settings/pages/ybcar_surfer/inded.dart';

import '../../../../models/surfer_model.dart';

class SurferController extends GetxController {
  final state = SurferState();

  void toggleCollapsed() {
    state.isCollapsed.value = !state.isCollapsed.value;
  }

  void setLoading(bool val) {
    state.requestLoading.value = val;
  }

  Future<void> sendYBBuddyRequest(BuildContext context) async {
    setLoading(true);
    String dateTime = DateTime.timestamp().millisecondsSinceEpoch.toString();



    // code for storing data in firestore
    try {
      await APis.db
          .collection('surferForm')
          .doc(dateTime)
          .set(DriverModel(
            id: dateTime,
            image: '',
            name: state.fNameCon.text.trim().toString() +
                state.lNameCon.text.trim().toString(),
            phone: '+1-' + state.phoneNumberCon.text.trim().toString(),
            email: state.emailCon.text.trim().toString(),
            pushToken: '',
            dateTime: dateTime,
            city: state.serviceOffering.value.toString(),
            isApproved: false,
          ).toJson())
          .then((value) {
        setLoading(false);
        clearController();
        showConfirmationDialogue(context);
      }).onError((error, stackTrace) {
        setLoading(false);
        Snackbar.showSnackBar('YB-Ride', error.toString(), Icons.error_outline);
      });
    } catch (e) {
      setLoading(false);
      Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.error_outline);
    }


  }

  Future<void> showConfirmationDialogue(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 10.0),
            Text("Request Successful!\nWe will contact you soon"),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  void clearController() {
    state.fNameCon.clear();
    state.lNameCon.clear();
    state.emailCon.clear();
    state.phoneNumberCon.clear();
    state.serviceOffering.value = 'Select';
  }
}
