
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/api/api.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/helper/session_controller.dart';
import 'package:yb_ride/screens/pages/invite_page/inded.dart';

class InviteCon extends GetxController{
  final state = InviteState();
  
  setLoading (bool value){
    state.loading.value=value;
  }
  
  Future<void> fetchFirstOrder()async{
    setLoading(true);
    try{
      var data = await APis.db.collection('all_bookings').where('id',isEqualTo: SessionController().userId.toString()).get();

      if(data.docs.length==0){
        state.carBooked.value=false;
        setLoading(false);
      }else{
        state.carBooked.value=true;
        setLoading(false);
      }
    }catch(e){
      setLoading(false);
      Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.error_outline);
    }
  }
}