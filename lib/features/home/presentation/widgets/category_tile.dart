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
            // White cells with a hairline edge, as in the design — the tint
            // that used to be here made the grid read as a block of chips.
            color: colors.surface,
            borderRadius: BorderRadius.circular(dimens.radiusMd),
            border: Border.all(color: colors.outline),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              // The artwork sits in the lower right and is allowed to run to
              // the cell's edges rather than being inset with the title.
              Positioned(
                right: 0,
                bottom: 0,
                top: dimens.spaceXl,
                left: dimens.spaceXxl,
                child: AppNetworkImage(
                  url: imageUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(dimens.spaceLg),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.appText.titleMd.copyWith(
                      fontWeight: FontWeight.w600,
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
