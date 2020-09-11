import 'package:audioplayer/services/audio_service.dart';
import 'package:audioplayer/services/google_analytics_services.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'data_service.dart';
import 'auth_services.dart';
import 'shared_preferencess_service.dart';

/// Service container
class PoolServices {
  final DataService dataService;
  final AuthService authService;
  final AudioService audioService;
  final SharedPreferencesService sharedPrefsService;
  final GoogleAnalyticsServices googleAnalyticsServices;

  PoolServices({
    this.dataService,
    this.authService,
    this.audioService,
    this.sharedPrefsService,
    this.googleAnalyticsServices,
  });

  static Future<PoolServices> initialize() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final sharedPrefsService = SharedPreferencesService(sharedPrefs);

    final _audioService = AudioService();
    _audioService.initState(sharedPrefsService);

    final dataService = DataService(sharedPrefsService);

    final authService = AuthService(sharedPrefsService, dataService);

    //GOOGLE ANALYTICS
    final googleAnalyticsService = new GoogleAnalyticsServices();

    return PoolServices(
      dataService: dataService,
      authService: authService,
      audioService: _audioService,
      sharedPrefsService: sharedPrefsService,
      googleAnalyticsServices: googleAnalyticsService,
    );
  }

  static PoolServices of(BuildContext context) {
    final provider = context
        .getElementForInheritedWidgetOfExactType<ServicesProvider>()
        .widget as ServicesProvider;
    return provider.services;
  }
}

class ServicesProvider extends InheritedWidget {
  final PoolServices services;

  ServicesProvider({Key key, this.services, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(ServicesProvider old) {
    if (services != old.services) {
      throw Exception('Services must be constant!');
    }
  }
}
