import 'package:flutter/material.dart';
import 'package:yb_ride/main.dart';

class IconContainer extends StatelessWidget {
  String iconName;
  double? height;
  double? width;
  IconContainer({Key? key,required this.iconName,this.height = 30.0,this.width=30.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isDarkTheme ? Image.asset("assets/whiteIcons/White${iconName}",
      width: height,
      height: width,
      fit: BoxFit.contain,
    ) : Image.asset('assets/icons/${iconName}',
      width: height,
      height: width,
      fit: BoxFit.contain,
    );
  }
}
