import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingServices extends GetxService {
  late SharedPreferences sharedPrefs;
  late PackageInfo packageInfo;
  FlutterSecureStorage storage = const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  Future<SettingServices> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
    packageInfo = await PackageInfo.fromPlatform();
    return this;
  }
}
