import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showProgressIndicator(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      print('loading');
      return Center(
        child:Container(
          height: 200,
          width: 200,
          child: Lottie.asset('assets/lottie/loading2.json'),
        ),
      );
    },
  );
}
