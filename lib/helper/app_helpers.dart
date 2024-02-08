import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget showProgressIndicator(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    child: Center(
      child: Container(
        height: 100,
        width: 100,
        child: Lottie.asset('assets/lottie/loading2.json'),
      ),
    ),
  );
}
