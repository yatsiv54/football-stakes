// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/academy
  $AssetsImagesAcademyGen get academy => const $AssetsImagesAcademyGen();

  /// Directory path: assets/images/icons
  $AssetsImagesIconsGen get icons => const $AssetsImagesIconsGen();
}

class $AssetsImagesAcademyGen {
  const $AssetsImagesAcademyGen();

  /// File path: assets/images/academy/bankroll.jpg
  AssetGenImage get bankroll =>
      const AssetGenImage('assets/images/academy/bankroll.jpg');

  /// File path: assets/images/academy/beyond.jpg
  AssetGenImage get beyond =>
      const AssetGenImage('assets/images/academy/beyond.jpg');

  /// File path: assets/images/academy/mental.jpg
  AssetGenImage get mental =>
      const AssetGenImage('assets/images/academy/mental.jpg');

  /// File path: assets/images/academy/news.jpg
  AssetGenImage get news =>
      const AssetGenImage('assets/images/academy/news.jpg');

  /// File path: assets/images/academy/odds.jpg
  AssetGenImage get odds =>
      const AssetGenImage('assets/images/academy/odds.jpg');

  /// File path: assets/images/academy/steps.jpg
  AssetGenImage get steps =>
      const AssetGenImage('assets/images/academy/steps.jpg');

  /// File path: assets/images/academy/trap.jpg
  AssetGenImage get trap =>
      const AssetGenImage('assets/images/academy/trap.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [
    bankroll,
    beyond,
    mental,
    news,
    odds,
    steps,
    trap,
  ];
}

class $AssetsImagesIconsGen {
  const $AssetsImagesIconsGen();

  /// File path: assets/images/icons/clock.png
  AssetGenImage get clock =>
      const AssetGenImage('assets/images/icons/clock.png');

  /// File path: assets/images/icons/delete.png
  AssetGenImage get delete =>
      const AssetGenImage('assets/images/icons/delete.png');

  /// File path: assets/images/icons/doc.png
  AssetGenImage get doc => const AssetGenImage('assets/images/icons/doc.png');

  /// File path: assets/images/icons/graph.png
  AssetGenImage get graph =>
      const AssetGenImage('assets/images/icons/graph.png');

  /// File path: assets/images/icons/info.png
  AssetGenImage get info => const AssetGenImage('assets/images/icons/info.png');

  /// Directory path: assets/images/icons/navbar
  $AssetsImagesIconsNavbarGen get navbar => const $AssetsImagesIconsNavbarGen();

  /// File path: assets/images/icons/pin.png
  AssetGenImage get pin => const AssetGenImage('assets/images/icons/pin.png');

  /// File path: assets/images/icons/remind1.png
  AssetGenImage get remind1 =>
      const AssetGenImage('assets/images/icons/remind1.png');

  /// File path: assets/images/icons/remind2.png
  AssetGenImage get remind2 =>
      const AssetGenImage('assets/images/icons/remind2.png');

  /// File path: assets/images/icons/search.png
  AssetGenImage get search =>
      const AssetGenImage('assets/images/icons/search.png');

  /// File path: assets/images/icons/spinner.png
  AssetGenImage get spinner =>
      const AssetGenImage('assets/images/icons/spinner.png');

  /// File path: assets/images/icons/star.png
  AssetGenImage get star => const AssetGenImage('assets/images/icons/star.png');

  /// File path: assets/images/icons/welcome.png
  AssetGenImage get welcome =>
      const AssetGenImage('assets/images/icons/welcome.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    clock,
    delete,
    doc,
    graph,
    info,
    pin,
    remind1,
    remind2,
    search,
    spinner,
    star,
    welcome,
  ];
}

class $AssetsImagesIconsNavbarGen {
  const $AssetsImagesIconsNavbarGen();

  /// File path: assets/images/icons/navbar/academy.png
  AssetGenImage get academy =>
      const AssetGenImage('assets/images/icons/navbar/academy.png');

  /// File path: assets/images/icons/navbar/chart.png
  AssetGenImage get chart =>
      const AssetGenImage('assets/images/icons/navbar/chart.png');

  /// File path: assets/images/icons/navbar/football.png
  AssetGenImage get football =>
      const AssetGenImage('assets/images/icons/navbar/football.png');

  /// File path: assets/images/icons/navbar/picks.png
  AssetGenImage get picks =>
      const AssetGenImage('assets/images/icons/navbar/picks.png');

  /// File path: assets/images/icons/navbar/settings.png
  AssetGenImage get settings =>
      const AssetGenImage('assets/images/icons/navbar/settings.png');

  /// List of all assets
  List<AssetGenImage> get values => [academy, chart, football, picks, settings];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
