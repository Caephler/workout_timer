import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';

class AdService {
  AdService._();

  static AdService instance = AdService._();

  InterstitialAd? _ad;

  Future<void> preloadInterstitialAd() async {
    /// If ad already loaded, skip
    if (_ad != null) {
      return;
    }

    /// If user has bought ad removal, skip
    if (await SharedPreferencesService.instance.getHasBoughtAdRemoval()) {
      return;
    }

    return InterstitialAd.load(
      adUnitId: 'ca-app-pub-8550524896014811/2306798944',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
        },
        onAdFailedToLoad: (error) {
          print(error);
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (await SharedPreferencesService.instance.getHasBoughtAdRemoval()) {
      return;
    }

    if (_ad != null) {
      await _ad?.show();
      _ad = null;
      return;
    }

    await preloadInterstitialAd();
    await _ad?.show();
    _ad = null;
    return;
  }
}
