import 'package:flutter/material.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/main.dart';

import '../../../../../../components/heading_text_widget.dart';
import '../../../../../../helper/app_colors.dart';

void showCustomAlertDialogTrips(
  BuildContext context,
  final String name,
  final String email,
  final String phone,
  final String completeFromAddress,
  final String completeToAddress,
  final String fromDateEpoch,
  final String toDateEpoch,
  final String fromTimeEpoch,
  final String toTimeEpoch,
  final String vehicleType,
  final double totalPrice,
  final bool isPickUp,
  final bool isDelivery,
  final bool isStandardProtection,
  final bool isLiabilityProtection,
  final bool isIHaveOwnProtection,
  final bool isCustomCoverage,
  final double totalCustomCoverage,
  final bool isUnlimitedMiles,
  final bool isUnder25years,
  final bool isPromoCodeApplied,
  final double promoDiscountAmount,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(0),
          child: CustomAlertDialog(
            name: name,
            email: email,
            phone: phone,
            completeFromAddress: completeFromAddress,
            completeToAddress: completeToAddress,
            fromDateEpoch: fromDateEpoch,
            toDateEpoch: toDateEpoch,
            fromTimeEpoch: fromTimeEpoch,
            toTimeEpoch: toTimeEpoch,
            vehicleType: vehicleType,
            totalPrice: totalPrice,
            isPickUp: isPickUp,
            isDelivery: isDelivery,
            isStandardProtection: isStandardProtection,
            isLiabilityProtection: isLiabilityProtection,
            isIHaveOwnProtection: isIHaveOwnProtection,
            isCustomCoverage: isCustomCoverage,
            totalCustomCoverage: totalCustomCoverage,
            isUnlimitedMiles: isUnlimitedMiles,
            isUnder25years: isUnder25years,
            isPromoCodeApplied: isPromoCodeApplied,
            promoDiscountAmount: promoDiscountAmount,
          ),
        ),
      );
    },
  );
}

class CustomAlertDialog extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String completeFromAddress;
  final String completeToAddress;
  final String fromDateEpoch;
  final String toDateEpoch;
  final String fromTimeEpoch;
  final String toTimeEpoch;
  final String vehicleType;
  final double totalPrice;
  final bool isPickUp;
  final bool isDelivery;
  final bool isStandardProtection;
  final bool isLiabilityProtection;
  final bool isIHaveOwnProtection;
  final bool isCustomCoverage;
  final double totalCustomCoverage;
  final bool isUnlimitedMiles;
  final bool isUnder25years;
  final bool isPromoCodeApplied;
  final double promoDiscountAmount;

  const CustomAlertDialog({
    super.key,
    required this.completeFromAddress,
    required this.completeToAddress,
    required this.fromDateEpoch,
    required this.toDateEpoch,
    required this.fromTimeEpoch,
    required this.toTimeEpoch,
    required this.vehicleType,
    required this.totalPrice,
    required this.isPickUp,
    required this.isDelivery,
    required this.isStandardProtection,
    required this.isLiabilityProtection,
    required this.isIHaveOwnProtection,
    required this.isCustomCoverage,
    required this.totalCustomCoverage,
    required this.isUnlimitedMiles,
    required this.isUnder25years,
    required this.isPromoCodeApplied,
    required this.promoDiscountAmount,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBgClr,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
// contentPadding: EdgeInsets.symmetric(horizontal: 13,vertical: 10),
      content: Container(
// width: 00,
// height: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Center(
                  child: HeadingTextWidget(
                    title: "Details",
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.blackColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(
                height: 15,
              ),
              _buildDetailItem('Name', name, context),
              _buildDetailItem('Email', email, context),
              _buildDetailItem('Phone', phone, context),
              _buildDetailItem('Complete From Address:',
                  completeFromAddress.toString(), context),
              _buildDetailItem('Complete to Address:',
                  completeToAddress.toString(), context),
              _buildDetailItem('Booking Date:', fromDateEpoch.toString(), context),
              _buildDetailItem('End Date:', toDateEpoch.toString(), context),
              _buildDetailItem('Start Time:', fromTimeEpoch.toString(), context),
              _buildDetailItem('End Time:', toTimeEpoch.toString(), context),
              _buildDetailItem(
                  'Vehicle Type: ', vehicleType.toString(), context),
              _buildDetailItem('Total Price:', totalPrice.toString(), context),
              _buildDetailItem('Is Pick Up:', isPickUp.toString(), context),
              _buildDetailItem('Is Delivery:', isDelivery.toString(), context),
              _buildDetailItem('Is Standard Protection:',
                  isStandardProtection.toString(), context),
              _buildDetailItem('Is Liability Protection:',
                  isLiabilityProtection.toString(), context),
              _buildDetailItem('Is I have Own Protection:',
                  isIHaveOwnProtection.toString(), context),
              _buildDetailItem(
                  'Is Custom Coverage:', isCustomCoverage.toString(), context),
              _buildDetailItem('Total custom Coverage:',
                  totalCustomCoverage.toString(), context),
              _buildDetailItem(
                  'Is Unlimited Miles:', isUnlimitedMiles.toString(), context),
              _buildDetailItem(
                  'Is Under 25 Years:', isUnder25years.toString(), context),
              _buildDetailItem('Complete From Address: ',
                  completeFromAddress.toString(), context),
              _buildDetailItem('Is Prom Code Applied:',
                  isPromoCodeApplied.toString(), context),
              _buildDetailItem('Promo Code Discount: ',
                  promoDiscountAmount.toString(), context),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailItem(String text, String val, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadingTextWidget(
          title: text,
          textColor: Theme.of(context).headingColor,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          maxLines: 3,
        ),
        SizedBox(
          height: 5,
        ),
        HeadingTextWidget(
          title: val,
          textColor: Theme.of(context).headingColor,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
          fontSize: 13,
          maxLines: 3,
        ),
      ],
    ),
  );
}
