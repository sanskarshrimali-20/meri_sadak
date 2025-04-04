import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService {
  static final AppVersionService _instance = AppVersionService._internal();

  factory AppVersionService() {
    return _instance;
  }

  AppVersionService._internal();

  String? version;
  String? buildNumber;

  Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;  // Version name
    buildNumber = packageInfo.buildNumber;  // Version code
  }
}