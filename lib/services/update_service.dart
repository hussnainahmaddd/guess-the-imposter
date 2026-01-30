import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class UpdateService {
  // TODO: Replace with your actual JSON URL
  static const String _versionCheckUrl = 'https://example.com/version.json'; 

  static Future<Map<String, dynamic>?> checkUpdate() async {
    try {
      // 1. Get current app version
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String currentVersion = packageInfo.version;

      // 2. Fetch remote config (Simulating network delay for now)
      // For real implementation:
      // final response = await http.get(Uri.parse(_versionCheckUrl));
      // if (response.statusCode != 200) return null;
      // final data = json.decode(response.body);
      
      // MOCK DATA FOR DEMO (Since we don't have a real URL yet)
      // Change 'min_version' to higher than 1.0.0 to test the dialog
      await Future.delayed(const Duration(seconds: 1)); // Simulate network
      final data = {
        "min_version": "1.0.0", 
        "store_url": "https://apps.apple.com/app-id"
      };

      final String minVersion = data['min_version'] as String;

      // 3. Compare versions
      if (_isVersionLower(currentVersion, minVersion)) {
        return data;
      }
      return null; // No update needed
    } catch (e) {
      debugPrint("Update check failed: $e");
      return null;
    }
  }

  static bool _isVersionLower(String current, String min) {
    List<int> cParts = current.split('.').map(int.parse).toList();
    List<int> mParts = min.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
        int c = i < cParts.length ? cParts[i] : 0;
        int m = i < mParts.length ? mParts[i] : 0;
        if (c < m) return true;
        if (c > m) return false;
    }
    return false;
  }
}
