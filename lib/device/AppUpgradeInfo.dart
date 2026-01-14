/// 应用升级信息【抽象接口】 - Dart规范的接口定义
/// 所有升级信息的核心字段，全部定义为【抽象get方法】
/// 所有子类必须实现本接口的全部抽象方法，强制遵循规范
abstract class AppUpgradeInfo {
  /// 最新版本号 (必填，如：1.1.0 / 2.0.1) - 抽象get方法
  String get latestVersion;

  /// 网页下载链接 (必填，其他机型兜底跳转) - 抽象get方法
  String get webDownloadUrl;

  /// 是否强制更新 (必填，true=必须更新才能用，false=可选更新) - 抽象get方法
  bool get isForceUpgrade;

  /// 更新内容描述 (可选，如：修复bug、优化体验) - 抽象get方法
  String get updateDesc;

  /// 安卓应用包名 (必填，跳转安卓各应用商店的核心参数) - 抽象get方法
  String get androidPackageName;

  /// iOS AppStore的应用ID (必填，跳转苹果商店的核心参数) - 抽象get方法
  String get iosAppStoreId;
}