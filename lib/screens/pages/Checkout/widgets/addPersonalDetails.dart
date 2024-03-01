import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_form_field.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/Checkout/controller.dart';

import '../../../../components/phone_number_input_field.dart';

Future addPersonalDataSheet(BuildContext context,CheckOutCon controller) async{

  showModalBottomSheet(
    isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      context: (context),
      builder: (context){
    return Container(
      color: Theme.of(context).scaffoldBgClr,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .02, vertical: mq.height * .02),
        child: Column(
          children: [
            ReuseableTextField(
                contr: controller.state.fNameCon,
                label: "First Name",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obsecure: false),
            SizedBox(height: 5,),
            ReuseableTextField(
                contr: controller.state.lNameCon,
                label: "Last Name",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obsecure: false),
            SizedBox(height: 5,),
            ReuseableTextField(
                contr: controller.state.emailCon,
                label: "E-mail",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obsecure: false),
            SizedBox(height: 5,),
            Obx(
                  () => PhoneNumberField(
                  controller.state.code.value,
                      () async {
                    final code = await controller.state.countryPicker
                        .showPicker(context: context,backgroundColor: Theme.of(context).scaffoldBgClr);
                    // Null check
                    if (code != null) {
                      controller.state.code.value = code;
                    }
                    ;
                  },
                  controller.state.phoneNumberCon,
                  controller.state.focused.value,
                      () {
                    controller.state.focused.value = !controller.state.focused.value;
                  },context),
            ),
            SizedBox(height: 20,),
            // Spacer(flex: ,),
            RoundButton(title: 'Save', onPress: () {
              print("saved pressed");
              if(controller.state.fNameCon.text.isNotEmpty &&
                  controller.state.lNameCon.text.isNotEmpty &&
                  controller.state.emailCon.text.isNotEmpty&&
                  controller.state.phoneNumberCon.text.isNotEmpty
              ){
                print(controller.state.fNameCon.text);
                controller.storeUserDetailsinConstants();
                Navigator.pop(context);
                // print(controller.state.phoneNumberCon.text.toString());
                // print("raw form"+getRawPhoneNumber(controller.state.phoneNumberCon.text.toString()));

              }else{
                Snackbar.showSnackBar("YB-Ride", "Enter all fields", Icons.error_outline);
                print("All items not added");
              }
            }),
            Spacer(flex: 3,),
          ],
        ),
      ),
    );
  });

}
