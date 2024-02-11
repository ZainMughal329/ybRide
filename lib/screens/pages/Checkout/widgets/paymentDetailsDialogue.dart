import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';
import 'package:yb_ride/components/heading_text_widget.dart';
import 'package:yb_ride/components/reuseable_button.dart';
import 'package:yb_ride/components/snackbar_widget.dart';
import 'package:yb_ride/components/text_widget.dart';
import 'package:yb_ride/main.dart';
import 'package:yb_ride/screens/pages/Checkout/widgets/paymentController.dart';

import '../../../../helper/app_colors.dart';
import '../../../../helper/app_constants.dart';

Future showRecipetSheet(
  BuildContext context,
  double noOfDays,
  String totalAmount,
  String invoiceDateTime,
  String serviceFromDateTime,
  String serviceToDateTime,
  double numberOfDays,
  String invoiceId,
  String paymentMethod,
  Map<String, double> charges,
) {
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _saveReceipt(var imageData) async {
    try {
      // Capture the screenshot of the container
      // final Uint8List imageBytes =

      // Save the image to the gallery
      await ImageGallerySaver.saveImage(imageData, quality: 100);

      // Show a snackbar to indicate successful saving
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Receipt saved to gallery')),
      // );
      Snackbar.showSnackBar('YB-Ride', "Receipt saved to gallery", Icons.done_all);
    } catch (e) {

      Snackbar.showSnackBar('YB-Ride', e.toString(), Icons.done_all);

    }
  }
  double totalAmountToPay = 0.0;
  double _calculateSubTotal() {
    double subTotal = 0;
    subTotal = AppConstants.totalPrice +
        AppConstants.bostonPoliceFees +
        AppConstants.bostonParking +
        AppConstants.bostonConventionCenter +
        AppConstants.tempDeposit;
    return subTotal;
  }


  double _calculateTax() {
    // return _calculateSubTotal() * 0.0625;
    return _calculateSubTotal() * (AppConstants.salesTaxPercentage / 100);
  }

  double _calculateTotal() {
    totalAmountToPay = _calculateSubTotal() + _calculateTax();
    AppConstants.totalAmountToPay = totalAmountToPay;
    return _calculateSubTotal() + _calculateTax();
  }

  return showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (_) {
        return Screenshot(
          controller: screenshotController,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingTextWidget(
                    title: 'YB-Ride Receipt',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SizedBox(height: 10),
                  SubHeadingTextWidget(
                    title: 'Total Rental Amount: $totalAmount',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SubHeadingTextWidget(
                    title: 'Invoice Date and Time: $invoiceDateTime',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SubHeadingTextWidget(
                    title: 'Service From Date and Time: $serviceFromDateTime',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SubHeadingTextWidget(
                    title: 'Service To Date and Time: $serviceToDateTime',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SubHeadingTextWidget(
                    title: 'Number of Days: $numberOfDays',
                    textColor: Theme.of(context).headingColor,
                  ),
                  // SubHeadingTextWidget(
                  //   title: 'Receipt Number: $receiptNumber',
                  //   textColor: Theme.of(context).headingColor,
                  // ),
                  SubHeadingTextWidget(
                    title: 'Invoice Id: $invoiceId',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SubHeadingTextWidget(
                    title: 'Payment Method: $paymentMethod',
                    textColor: Theme.of(context).headingColor,
                  ),
                  Divider(
                    color: Theme.of(context).headingColor,
                  ),
                  SizedBox(height: 20),
                  HeadingTextWidget(
                    title: 'Details:',
                    textColor: Theme.of(context).headingColor,
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: charges.entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SubHeadingTextWidget(
                            //   title: 'QTY: ${noOfDays}',
                            //   textColor: Theme.of(context).headingColor,
                            // ),
                            // Spacer(),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: SubHeadingTextWidget(
                                  title: '${entry.key}',
                                  textAlign: TextAlign.left,
                                  textColor: Theme.of(context).headingColor,
                                )),
                            Spacer(),
                            SubHeadingTextWidget(
                              title: '\$${entry.value.toStringAsFixed(2)}',
                              textColor: Theme.of(context).headingColor,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Divider(
                    color: Theme.of(context).headingColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingTextWidget(
                        title: 'SubTotal:',
                        textColor: Theme.of(context).headingColor,
                      ),
                      SubHeadingTextWidget(
                        title: '\$${_calculateSubTotal().toStringAsFixed(2)}',
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingTextWidget(
                        title:
                            'Sales Tax (${AppConstants.salesTaxPercentage}%):',
                        textColor: Theme.of(context).headingColor,
                      ),
                      SubHeadingTextWidget(
                        title: '\$${_calculateTax().toStringAsFixed(2)}',
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).headingColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingTextWidget(
                        title: 'Total:',
                        textColor: Theme.of(context).headingColor,
                      ),
                      SubHeadingTextWidget(
                        title: '\$${_calculateTotal().toStringAsFixed(2)}',
                        textColor: Theme.of(context).headingColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  RoundButton(
                      title: "Pay",
                      onPress: () async {
                        screenshotController.capture().then(
                              (Uint8List? image) {
                            _saveReceipt(image);
                          },
                        );
                        Navigator.pop(context);
                        final payController = PaymentController();
                        await payController.makePayment(
                            context, totalAmountToPay);
                      }),
                ],
              ),
            ),
          ),
        );
      });
}
