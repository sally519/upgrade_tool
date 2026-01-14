/// 手机品牌枚举类 - 管理所有支持的手机厂商，替代硬编码String
/// 所有判断一律使用枚举值，杜绝字符串拼写错误
enum DeviceBrand {
  /// 苹果iOS
  ios,

  /// 华为
  huawei,

  /// 小米 (含红米Redmi)
  xiaomi,

  /// OPPO (含一加OnePlus、真我Realme)
  oppo,

  /// VIVO (含iQOO)
  vivo,

  /// 荣耀 (独立品牌，优先级最高)
  honor,

  /// 其他安卓机型 (三星、魅族、中兴等)
  other,
}

/// 枚举拓展方法 - 给DeviceBrand枚举增加【获取中文名称】的能力
/// 优势：枚举和中文名称绑定，无需在工具类里写switch，代码更优雅
extension DeviceBrandExtension on DeviceBrand {
  /// 获取当前枚举对应的【中文品牌名】
  String get chineseName {
    switch (this) {
      case DeviceBrand.ios:
        return "苹果";
      case DeviceBrand.huawei:
        return "华为";
      case DeviceBrand.xiaomi:
        return "小米";
      case DeviceBrand.oppo:
        return "OPPO";
      case DeviceBrand.vivo:
        return "vivo";
      case DeviceBrand.honor:
        return "荣耀";
      case DeviceBrand.other:
        return "其他品牌";
    }
  }
}
