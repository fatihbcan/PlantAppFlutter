import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Inline failure state with a retry affordance.
///
/// Used for a whole page and for a single failed section alike; the caller
/// controls the surrounding layout.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    required this.message,
    required this.retryLabel,
    required this.onRetry,
    this.isCompact = false,
    super.key,
  });

  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  /// Drops the icon and shrinks padding, for errors inside a section.
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return Semantics(
      liveRegion: true,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: dimens.pageGutter,
          vertical: isCompact ? dimens.spaceLg : dimens.spaceXxl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (!isCompact) ...<Widget>[
              Icon(
                Icons.cloud_off_rounded,
                size: dimens.iconMd * 2,
                color: context.appColors.onCanvasSubtle,
              ),
              SizedBox(height: dimens.spaceLg),
            ],
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.appText.bodyMd.copyWith(
                color: context.appColors.onCanvasMuted,
              ),
            ),
            SizedBox(height: dimens.spaceMd),
            TextButton(
              onPressed: onRetry,
              style: TextButton.styleFrom(
                foregroundColor: context.appColors.brand,
                textStyle: context.appText.button,
              ),
              child: Text(retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}
