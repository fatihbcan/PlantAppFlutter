import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Remote image with a themed placeholder and a graceful failure state.
///
/// Every remote image in the app goes through this widget so loading and
/// error treatment stay identical everywhere.
class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.semanticLabel,
    super.key,
  });

  final String url;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) return _Placeholder(width: width, height: height);

    return Image.network(
      url,
      fit: fit,
      width: width,
      height: height,
      semanticLabel: semanticLabel,
      excludeFromSemantics: semanticLabel == null,
      // Decoding at display size keeps big CDN images off the raster budget.
      cacheWidth: _cacheDimension(context, width),
      loadingBuilder:
          (BuildContext context, Widget child, ImageChunkEvent? progress) {
            if (progress == null) return child;
            return _Placeholder(width: width, height: height);
          },
      errorBuilder: (BuildContext context, Object error, StackTrace? stack) =>
          _Placeholder(
            width: width,
            height: height,
            icon: Icons.image_not_supported_outlined,
          ),
    );
  }

  int? _cacheDimension(BuildContext context, double? logicalWidth) {
    if (logicalWidth == null || !logicalWidth.isFinite) return null;
    return (logicalWidth * MediaQuery.devicePixelRatioOf(context)).round();
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.width, this.height, this.icon});

  final double? width;
  final double? height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: context.appColors.surfaceMuted,
      alignment: Alignment.center,
      child: icon == null
          ? null
          : Icon(
              icon,
              size: context.appDimens.iconMd,
              color: context.appColors.onCanvasSubtle,
            ),
    );
  }
}
