import 'package:shared_preferences/shared_preferences.dart';

class Application {
  static bool debug = true;
  static String title = "Anfari";
  static late SharedPreferences preferences;

  Future<void> setPrefrences() async {
    preferences = await SharedPreferences.getInstance();
  }

  /// Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
