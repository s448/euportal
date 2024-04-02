import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  // Singleton pattern to have a single instance of SharedPreferencesService
  factory SharedPreferencesService() {
    _instance ??= SharedPreferencesService._();
    return _instance!;
  }

  SharedPreferencesService._();

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  // Save a string value to SharedPreferences
  Future<void> saveString(String key, String value) async {
    await _preferences!.setString(key, value);
  }

  // Get a string value from SharedPreferences
  String? getString(String key) {
    return _preferences!.getString(key);
  }

  // Save a boolean value to SharedPreferences
  Future<void> saveBool(String key, bool value) async {
    await _preferences!.setBool(key, value);
  }

  // Get a boolean value from SharedPreferences
  bool? getBool(String key) {
    return _preferences!.getBool(key);
  }

  ///is user authenticated
  isUserLoggedInAndRemembered() => getBool('remember_me') ?? false;
}
