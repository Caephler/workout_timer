import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:workout_timer/common/storage/shared_prefs.dart';

class AdService {
  AdService._();

  static AdService instance = AdService._();

  RewardedAd? _ad;

  Future<void> preloadRewardedAd() async {
    /// If ad already loaded, skip
    if (_ad != null) {
      return;
    }

    /// If user has bought ad removal, skip
    if (await SharedPreferencesService.instance.getHasBoughtAdRemoval()) {
      return;
    }

    return RewardedAd.load(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
        },
        onAdFailedToLoad: (error) {
          print(error);
        },
      ),
    );
  }

  Future<void> showRewardedAd() async {
    if (await SharedPreferencesService.instance.getHasBoughtAdRemoval()) {
      return;
    }

    if (_ad != null) {
      await _ad?.show(onUserEarnedReward: (ad, item) {});
      print('ad shown, clearing ad');
      _ad = null;
      return;
    }

    await preloadRewardedAd();
    await _ad?.show(onUserEarnedReward: (ad, item) {});
    print('ad shown, clearing ad');
    _ad = null;
    return;
  }
}
