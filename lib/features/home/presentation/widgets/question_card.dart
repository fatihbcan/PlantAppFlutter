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
                // The design's scrim is a deep, late fade — the photo stays
                // clear down to two thirds of the card and then goes almost
                // black behind the title, rather than being greyed all over.
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: <double>[0.6, 0.8, 1],
                      colors: <Color>[
                        Colors.transparent,
                        Color(0x8A000000),
                        Color(0xCC000000),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: dimens.spaceLg,
                  right: dimens.spaceLg,
                  bottom: dimens.spaceLg,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.appText.titleSm.copyWith(
                      height: 1.35,
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
