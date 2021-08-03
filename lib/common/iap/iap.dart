import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IAPService {
  late Stream<List<PurchaseDetails>> _purchaseStream;

  IAPService._();

  static IAPService instance = IAPService._();
  static Set<String> _productIds = Set.from([
    'remove_ads',
  ]);

  Future<void> init() async {
    _purchaseStream = InAppPurchase.instance.purchaseStream;
    _purchaseStream.listen(
      (eventList) {
        for (PurchaseDetails details in eventList) {
          if (details.productID == 'remove_ads') {
            if (details.status == PurchaseStatus.pending) {
              // Handle pending
            }
            if (details.status == PurchaseStatus.purchased) {
              SharedPreferencesService.instance.setHasBoughtAdRemoval(true);
              InAppPurchase.instance.completePurchase(details);
              Fluttertoast.showToast(msg: 'Thank you for your purchase!');
            }
            if (details.status == PurchaseStatus.restored) {
              SharedPreferencesService.instance.setHasBoughtAdRemoval(true);
              InAppPurchase.instance.completePurchase(details);
              Fluttertoast.showToast(msg: 'Purchase restored!');
            }
            // Ignore error status
          }
        }
      },
    );

    try {
      await InAppPurchase.instance.restorePurchases();
    } catch (e) {
      // Pass, ignore errors here
    }
  }

  Future<bool> get isReady {
    return InAppPurchase.instance.isAvailable();
  }

  Future<void> restorePurchases() async {
    return InAppPurchase.instance.restorePurchases();
  }

  Stream<List<PurchaseDetails>> get purchaseStream {
    return _purchaseStream;
  }

  Future<bool> buyAdRemoval() async {
    assert(await isReady == true);
    ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      // Handle error
      return false;
    }
    List<ProductDetails> products = response.productDetails;
    assert(products.length == 1);
    ProductDetails adRemoveDetails = products.first;

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: adRemoveDetails);

    bool didReturn = await InAppPurchase.instance
        .buyNonConsumable(purchaseParam: purchaseParam);

    return didReturn;
  }
}
