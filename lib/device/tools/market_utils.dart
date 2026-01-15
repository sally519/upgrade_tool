import 'package:upgrade_tool/device/AppUpgradeInfo.dart';
import 'package:upgrade_tool/device/enum/DeviceBrand.dart';
import 'package:url_launcher/url_launcher.dart';

/// 应用市场跳转工具类
class MarketUtils {
  /// 跳转对应应用市场
  /// [packageInfo] 你的抽象模型（包含version、url）
  /// [appId] 各应用市场的APP唯一ID（必填！需替换为你的真实ID）
  ///         例：苹果AppStore的id是数字（如123456789），华为/小米的是包名
  static Future<void> jumpToMarket(
    AppUpgradeInfo packageInfo,
    String appId,
    DeviceBrand deviceType,
  ) async {
    String marketUrl = '';
    // 1. 按设备类型生成对应应用市场链接
    switch (deviceType) {
      case DeviceBrand.ios:
        // 苹果AppStore跳转链接（替换为你的AppId）
        marketUrl = 'https://apps.apple.com/cn/app/id$appId';
        break;
      case DeviceBrand.huawei:
        // 华为应用市场Scheme
        marketUrl = 'appmarket://details?id=$appId';
        break;
      case DeviceBrand.xiaomi:
        // 小米应用市场Scheme
        marketUrl = 'miui://appmarket/appdetails?id=$appId';
        break;
      case DeviceBrand.oppo:
        // OPPO应用市场Scheme
        marketUrl = 'oppomarket://details?packagename=$appId';
        break;
      case DeviceBrand.vivo:
        // VIVO应用市场Scheme
        marketUrl = 'vivomarket://details?id=$appId';
        break;
      case DeviceBrand.honor:
        // 荣耀应用市场Scheme
        marketUrl = 'honorappmarket://app/C00000$appId';
        break;
      case DeviceBrand.other:
        // 其他安卓机型 → 跳网页下载（PackageInfo中的url）
        marketUrl = packageInfo.webDownloadUrl;
        break;
    }

    // 2. 执行跳转（失败则跳网页下载）
    try {
      Uri uri = Uri.parse(marketUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // 应用市场未安装 → 跳网页下载
        await launchUrl(
          Uri.parse(packageInfo.webDownloadUrl),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // 跳转异常 → 兜底跳网页
      await launchUrl(
        Uri.parse(packageInfo.webDownloadUrl),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
