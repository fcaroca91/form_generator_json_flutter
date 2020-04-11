import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class DataStoreOffline {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> saveData(Map<String, dynamic> jsonData) async {
    final SharedPreferences prefs = await _prefs;

    await prefs.setString(
      'customRequirementList',
      json.encode(jsonData),
    );
  }

  static Future<String> extractData() async {
    final SharedPreferences prefs = await _prefs;

    return prefs.getString('customRequirementList');
  }
}
