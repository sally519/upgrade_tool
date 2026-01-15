import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart'; // 新增导入

/// 版本对比工具类
class VersionUtils {
  /// 对比本地版本是否低于最新版本（内部自动获取本地版本）
  /// [remoteVersion] PackageInfo中的最新版本
  static Future<bool> isNeedUpdate(String remoteVersion) async {
    // 1. 自动获取本地APP版本
    String localVersion = '';
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      localVersion = packageInfo.version; // 本地版本号（如1.0.0）
    } catch (e) {
      debugPrint('获取本地版本失败：$e');
      return false; // 获取失败则认为无需更新
    }

    // 2. 空值校验
    if (localVersion.isEmpty || remoteVersion.isEmpty) return false;

    // 3. 版本号分割与对比（逻辑不变，仅本地版本改为内部获取）
    List<int> localParts = _versionToIntList(localVersion);
    List<int> remoteParts = _versionToIntList(remoteVersion);

    int maxLength = localParts.length > remoteParts.length
        ? localParts.length
        : remoteParts.length;
    while (localParts.length < maxLength) {
      localParts.add(0);
    }
    while (remoteParts.length < maxLength) {
      remoteParts.add(0);
    }

    for (int i = 0; i < maxLength; i++) {
      if (remoteParts[i] > localParts[i]) {
        return true;
      } else if (remoteParts[i] < localParts[i]) {
        return false;
      }
    }
    return false;
  }

  /// 版本号转int数组（私有方法，逻辑不变）
  static List<int> _versionToIntList(String version) {
    try {
      return version.split('.').map((e) => int.parse(e.trim())).toList();
    } catch (e) {
      return [];
    }
  }
}
