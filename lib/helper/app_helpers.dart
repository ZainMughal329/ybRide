import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

showProgressIndicator(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      print('loading');
      return Center(
        child:Container(
          height: 100,
          width: 100,
          child: Lottie.asset('assets/lottie/loading2.json'),
        ),
      );
    },
  );
}
