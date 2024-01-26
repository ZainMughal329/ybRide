import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showProgressIndicator(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Center(
      child: CircularProgressIndicator(),
    ),
  );
}
