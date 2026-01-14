import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:upgrade_tool/device/enum/DeviceBrand.dart';

/// 手机品牌识别工具类 - 【枚举版】
/// 核心方法返回 DeviceBrand 枚举，无任何硬编码String，类型安全
class DeviceBrandUtils {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// 【核心方法】精准识别手机厂商，返回【枚举类型】DeviceBrand
  /// 识别优先级：荣耀 > 华为 > 小米 > OPPO > VIVO > 其他
  static Future<DeviceBrand> getPhoneBrand() async {
    try {
      if (Platform.isIOS) {
        // iOS设备 直接返回枚举：DeviceBrand.ios
        return DeviceBrand.ios;
      } else if (Platform.isAndroid) {
        // Android设备 精准识别厂商
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        String brand = androidInfo.brand.toLowerCase().trim();
        String manufacturer = androidInfo.manufacturer.toLowerCase().trim();

        // ======================== 识别逻辑不变，返回枚举即可 ========================
        // 1. 荣耀 优先识别！！！ 彻底避免荣耀被识别成华为
        if (brand.contains("honor") || manufacturer.contains("honor")) {
          return DeviceBrand.honor;
        }
        // 2. 华为
        if (brand.contains("huawei") || manufacturer.contains("huawei")) {
          return DeviceBrand.huawei;
        }
        // 3. 小米 (包含红米redmi)
        if (brand.contains("xiaomi") ||
            manufacturer.contains("xiaomi") ||
            brand.contains("redmi")) {
          return DeviceBrand.xiaomi;
        }
        // 4. OPPO 系列 (一加oneplus、真我realme 都归为OPPO)
        if (brand.contains("oppo") ||
            manufacturer.contains("oppo") ||
            brand.contains("oneplus") ||
            brand.contains("realme")) {
          return DeviceBrand.oppo;
        }
        // 5. VIVO 系列 (iQOO 归为VIVO)
        if (brand.contains("vivo") ||
            manufacturer.contains("vivo") ||
            brand.contains("iqoo")) {
          return DeviceBrand.vivo;
        }

        // 其他安卓厂商
        return DeviceBrand.other;
      } else {
        // 其他系统（windows/mac等）
        return DeviceBrand.other;
      }
    } catch (e) {
      // 异常兜底：识别失败不会崩溃，返回【其他品牌】枚举
      return DeviceBrand.other;
    }
  }
}
