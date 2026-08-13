import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/shared/widgets/app_network_image.dart';

/// One article card in the horizontal "Get Started" carousel.
class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.title,
    required this.imageUrl,
    required this.width,
    required this.onTap,
    super.key,
  });

  final String title;
  final String imageUrl;

  /// Sized by the carousel, which knows the viewport width.
  final double width;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;
    final colors = context.appColors;

    return Semantics(
      button: true,
      label: title,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dimens.radiusMd),
        child: SizedBox(
          width: width,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(dimens.radiusMd),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                AppNetworkImage(url: imageUrl, width: width),
                // Scrim keeps the title legible over any photograph.
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Colors.transparent, colors.scrim],
                    ),
                  ),
                ),
                Positioned(
                  left: dimens.spaceMd,
                  right: dimens.spaceMd,
                  bottom: dimens.spaceMd,
                  child: Text(
                    title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.appText.titleMd.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
