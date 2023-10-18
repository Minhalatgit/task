import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/user_model.dart';

class AppPreferences {
  static late final SharedPreferences _preferences;

  static Future<SharedPreferences> init() async => _preferences = await SharedPreferences.getInstance();

  AppPreferences._internal();

  static const String _prefTypeBool = "BOOL";
  static const String _prefTypeInteger = "INTEGER";
  static const String _prefTypeDouble = "DOUBLE";
  static const String _prefTypeString = "STRING";

  /// Constants for Preference-Keys
  static const String _prefDeviceId = "DEVICE_ID";

  static const String _prefUserId = "USER_ID";
  static const String _prefUserDetails = "USER_DETAILS";
  static const String _prefAccessToken = "ACCESS_TOKEN";
  static const String _prefLoggedIn = "IS_LOGGED_IN";
  static const String _prefRole = "ROLE";

  //--------------------------------------------------- Public Preference Methods -------------------------------------------------------------
  static void _removeValue(String key) {
    //Remove String
    _preferences.remove(key);
  }

  static void setUserId({required String userId}) => _setPreference(prefName: _prefUserId, prefValue: userId, prefType: _prefTypeString);

  static Future<String> getUserId() async => await _getPreference(prefName: _prefUserId);

  static void setUserDetails({required String data}) => _setPreference(prefName: _prefUserDetails, prefValue: data, prefType: _prefTypeString);

  static Future<UserModel?> getUserDetails() async {
    if (_preferences.getString(_prefUserDetails) == null) return null;
    Map<String, dynamic> userMap = jsonDecode(_preferences.getString(_prefUserDetails)!);
    var userDetails = UserModel.fromJson(userMap);
    return userDetails;
  }

  static void setIsLoggedIn({required bool loggedIn}) => _setPreference(prefName: _prefLoggedIn, prefValue: loggedIn, prefType: _prefTypeBool);

  static bool getIsLoggedIn() {
    return _preferences.getBool(_prefLoggedIn) ?? false;
  }

  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------
  /// @usage -> This is a generalized method to set preferences with required Preference-Name(Key) with Preference-Value(Value) and Preference-Value's data-type.
  static Future<bool> _setPreference({required String prefName, required dynamic prefValue, required String prefType}) async {
    switch (prefType) {
      case _prefTypeBool:
        return _preferences.setBool(prefName, prefValue);
      case _prefTypeInteger:
        return _preferences.setInt(prefName, prefValue);
      case _prefTypeDouble:
        return _preferences.setDouble(prefName, prefValue);
      case _prefTypeString:
        return _preferences.setString(prefName, prefValue);
      default:
        return Future.value(false);
    }
  }

  static Future<dynamic> _getPreference({required prefName}) async => _preferences.get(prefName);

  static Future<bool> clearPreference() => _preferences.clear();
}
