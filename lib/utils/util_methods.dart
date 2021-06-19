import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:instancy_task/utils/app_constants.dart';
import 'app_colors.dart';

class ToastService {
  void showLoadingIndicator() {
    BotToast.showCustomLoading(toastBuilder: (_) {
      return Container(
        width: 200,
        height: 120,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: CircularProgressIndicator()),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Loading...')),
          ],
        ),
      );
    });
  }
}

BoxDecoration applyShadow({
  double containerRadius,
}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(containerRadius), //border corner radius
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 7, // blur radius
        offset: Offset(0, 2), // changes position of shadow
        //first paramerter of offset is left-right
        //second parameter is top to down
      ),
      //we can set more BoxShadow() here
    ],
  );
}

TextStyle titleTextStyle() {
  return TextStyle(
    color: AppColors.mainTextColor,
    fontWeight: FontWeight.w500,
    fontSize: 17,
  );
}

TextStyle spTextStyle() {
  return TextStyle(
    color: AppColors.mainTextColor,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}

TextStyle unitPriceStyle(String sp) {
  return TextStyle(
      color: AppColors.subtitleColor,
      fontWeight: FontWeight.normal,
      fontSize: 14,
      decoration: sp != "0" ? TextDecoration.lineThrough : TextDecoration.none);
}

TextStyle discountStyle() {
  return TextStyle(
    color: AppColors.greenColor,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}

String calculateDiscount({String totalPrice, String discountPrice}) {
  double discountPercentage =
      (int.parse(discountPrice) / int.parse(totalPrice)) * 100;

  return discountPercentage.round().toString() + "% off";
}
