import 'package:flutter/cupertino.dart';

class GoogleAnalyticsServices {
  GoogleAnalyticsServices() {}

  Future<void> setCurrentScreen(String screen,
      {screenClassOverride = 'Flutter'}) async {}

  Future<void> setAnalyticsEvent(String eventName,
      [Map<String, dynamic> parameters]) async {}

  Future<void> campaignDetails() async {}

  Future<void> purchase(
      {@required double value,
      @required String transactionId,
      String coupon = ''}) async {}

  Future<void> setUserId(String userId) async {}
}
