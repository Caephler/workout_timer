import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:line_icons/line_icons.dart';
import 'package:workout_timer/common/iap/iap.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:workout_timer/common/text.dart';

class IAPStatusBadge extends StatefulWidget {
  const IAPStatusBadge({Key? key}) : super(key: key);

  @override
  _IAPStatusBadgeState createState() => _IAPStatusBadgeState();
}

class _IAPStatusBadgeState extends State<IAPStatusBadge> {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  bool shouldShow = true;

  @override
  void initState() {
    super.initState();
    _subscription = IAPService.instance.purchaseStream.listen((eventList) {
      for (PurchaseDetails details in eventList) {
        if (details.productID == 'remove_ads') {
          if (details.status == PurchaseStatus.purchased ||
              details.status == PurchaseStatus.restored) {
            setState(
              () {
                shouldShow = false;
              },
            );
          }
        }
      }
    });

    SharedPreferencesService.instance
        .getHasBoughtAdRemoval()
        .then((hasPurchase) {
      if (hasPurchase) {
        setState(() {
          shouldShow = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!shouldShow) {
      return SizedBox.shrink();
    }

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        IAPService.instance.buyAdRemoval();
      },
      icon: Icon(
        LineIcons.starAlt,
        size: 20,
      ),
      label: Text(
        'Remove Ads',
        style: AppTextStyles.body.getStyleFor(
          5,
          color: Colors.white,
        ),
      ),
    );
  }
}
