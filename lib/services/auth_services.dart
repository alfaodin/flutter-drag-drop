import 'data_service.dart';
import 'external_auth_services.dart';
import './shared_preferencess_service.dart';

class AuthService {
  final DataService _dataService;
  final SharedPreferencesService _sharedPrefs;
  final ExternalAuthService _externalAuthService;

  AuthService(this._sharedPrefs, this._dataService)
      : _externalAuthService = ExternalAuthService();
}
