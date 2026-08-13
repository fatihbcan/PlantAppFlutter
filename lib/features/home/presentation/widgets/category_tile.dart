import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/shared/widgets/app_network_image.dart';

/// One cell of the categories grid: title on the left, artwork on the right.
class CategoryTile extends StatelessWidget {
  const CategoryTile({
    required this.title,
    required this.imageUrl,
    required this.semanticsLabel,
    required this.onTap,
    super.key,
  });

  final String title;
  final String imageUrl;
  final String semanticsLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    return Semantics(
      button: true,
      label: semanticsLabel,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(dimens.radiusMd),
        child: Container(
          decoration: BoxDecoration(
            // The design tints these cells rather than leaving them the
            // page's white, which is what separates the grid from the canvas.
            color: colors.surfaceMuted,
            borderRadius: BorderRadius.circular(dimens.radiusMd),
            border: Border.all(color: colors.outline),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: FractionallySizedBox(
                  widthFactor: 0.62,
                  heightFactor: 0.86,
                  child: AppNetworkImage(url: imageUrl, fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(dimens.spaceMd),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.appText.titleMd.copyWith(
                      color: colors.onCanvas,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
