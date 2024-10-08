import 'package:shared_preferences/shared_preferences.dart';


class Prefs {
  static SharedPreferences? _pref;

  static Future init() async {
    return SharedPreferences.getInstance().then((p) {
      _pref = p;
    });
  }

  static dynamic getValue(String key, {dynamic defaultValue}) {
    if (_pref!.containsKey(key)) {
      return _pref?.get(key);
    } else {
      return defaultValue;
    }
  }

  static clearPrefs() {
    //String fcmToken = getValue(PrefConstants.FCM_TOKEN);
    _pref?.clear();
    //setValue(PrefConstants.FCM_TOKEN, fcmToken);
  }

  static void setValue(String key, dynamic value) {
    switch (value.runtimeType) {
      case String:
        _pref?.setString(key, value);
        return;
      case bool:
        _pref?.setBool(key, value);
        return;
      case double:
        _pref?.setDouble(key, value);
        return;
      case int:
        _pref?.setInt(key, value);
        return;
      case List:
        _pref?.setStringList(key, value);
        return;
    }
  }
}
// class Prefs {
//   static SharedPreferences? _prefs;

//   // call this method from iniState() function of mainApp().
//   static Future<SharedPreferences> init() async {
//     _prefs = await SharedPreferences.getInstance();
//     return _prefs!;
//   }

//   //sets
//   static Future<bool> setBool(String key, bool value) async =>
//       await _prefs!.setBool(key, value);

//   static Future<bool> setDouble(String key, double value) async =>
//       await _prefs!.setDouble(key, value);

//   static Future<bool> setInt(String key, int value) async =>
//       await _prefs!.setInt(key, value);

//   static Future<bool> setString(String key, String value) async =>
//       await _prefs!.setString(key, value);

//   static Future<bool> setStringList(String key, List<String> value) async =>
//       await _prefs!.setStringList(key, value);

//   //gets
//   static bool? getBool(String key) => _prefs!.getBool(key);

//   static double? getDouble(String key) => _prefs!.getDouble(key);

//   static int? getInt(String key) => _prefs!.getInt(key);

//   static String? getString(String key) => _prefs!.getString(key);

//   static List<String>? getStringList(String key) => _prefs!.getStringList(key);

//   //deletes..
//   static Future<bool>? remove(String key) async => await _prefs!.remove(key);

//   static Future<bool>? clear() async => await _prefs!.clear();
// }