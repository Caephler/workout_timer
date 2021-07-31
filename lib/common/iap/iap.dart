import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';

class IAPService {
  Stream<List<PurchaseDetails>> _purchaseStream;

  IAPService._() : _purchaseStream = InAppPurchase.instance.purchaseStream {
    _purchaseStream.listen(
      (eventList) {
        for (PurchaseDetails details in eventList) {
          if (details.productID == 'remove_ads') {
            if (details.status == PurchaseStatus.purchased ||
                details.status == PurchaseStatus.restored) {
              SharedPreferencesService.instance.setHasBoughtAdRemoval(true);
            }
          }
        }
      },
    );
  }

  static IAPService instance = IAPService._();
  static Set<String> _productIds = Set.from([
    'remove_ads',
  ]);

  Future<bool> get isReady {
    return InAppPurchase.instance.isAvailable();
  }

  Stream<List<PurchaseDetails>> get purchaseStream {
    return _purchaseStream;
  }

  Future<bool> buyAdRemoval() async {
    // assert(await isReady == true);
    print('isReady ${await isReady}');
    ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      // Handle error
      return false;
    }
    List<ProductDetails> products = response.productDetails;
    assert(products.length == 1);
    ProductDetails adRemoveDetails = products.first;
    print(adRemoveDetails.price);
    print(adRemoveDetails.description);
    print(adRemoveDetails.title);
    print(adRemoveDetails.currencySymbol);

    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: adRemoveDetails);

    bool didReturn = await InAppPurchase.instance
        .buyNonConsumable(purchaseParam: purchaseParam);

    return didReturn;
  }
}
