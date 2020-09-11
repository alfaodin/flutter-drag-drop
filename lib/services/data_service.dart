import 'dart:async';
import 'dart:convert';

import '../services/shared_preferencess_service.dart';

class DataService {
  final _user$ = Object();
  final SharedPreferencesService _prefs;

  DataService(this._prefs);
}
