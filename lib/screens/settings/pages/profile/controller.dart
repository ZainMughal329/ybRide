import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/settings/pages/profile/index.dart';

class ProfileController extends GetxController{
  final state = profileState();
  void onFocusChange(bool value) {
    state.focused.value = value;
  }

  setLoading(bool val){
    state.loading.value=val;
  }

  Future<void> fetchUserDetails() async{
    setLoading(true);
    try{
      var userData= await APis.db.collection('users').doc(SessionController().userId.toString()).get().then((value){
        String name = value['name'];
        String email = value['email'];
        state.fNameCon.text=name.toString();
        state.emailCon.text=email.toString();
        setLoading(false);

      }).onError((error, stackTrace){
        setLoading(false);
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error_outline);
      });

    }catch(e){
      setLoading(false);
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }

  Future<void> updateUserData() async{
    setLoading(true);
    try{
      await APis.db.collection('users').doc(SessionController().userId.toString()).update({
        'name':state.fNameCon.text.trim().toString(),
      }).then((value){
        setLoading(false);
        Snackbar.showSnackBar("YB-Ride", 'Updated Successfully', Icons.done_all);

      }).onError((error, stackTrace){
        setLoading(false);
        Snackbar.showSnackBar("YB-Ride", error.toString(), Icons.error_outline);
      });
    }catch(e){
      setLoading(false);
      Snackbar.showSnackBar("YB-Ride", e.toString(), Icons.error_outline);
    }
  }
}