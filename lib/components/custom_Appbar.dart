
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final IconData? leadingIcon;
  final String centerTitle;
  final IconData? trailingIcon;
  final bool isLeading;

  CustomAppBarWidget({
    this.leadingIcon,
    required this.centerTitle,
    this.trailingIcon, required this.isLeading,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set your preferred background color
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Set shadow color
            blurRadius: 4, // Set the blur radius for the 3D effect
            offset: Offset(0, 2), // Set the offset for the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            isLeading ? IconButton(
              icon: Icon(leadingIcon),
              onPressed: () {
                // Handle leading icon press
              },
            ) : Container(),
            SizedBox(
              width: mq.width * .02,
            ),
            Expanded(
              child: Text(
                centerTitle,
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
            ),
            IconButton(
              icon: Icon(trailingIcon),
              onPressed: () {
                // Handle trailing icon press
              },
            ),
          ],
        ),
      ),
    );
  }
}