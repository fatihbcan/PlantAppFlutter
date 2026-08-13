import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// The one filled call-to-action button in the app.
///
/// Takes primitives only: no feature may hand it a domain object.
class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  final String label;

  /// `null` disables the button — the caller decides, not this widget.
  final VoidCallback? onPressed;

  /// Swaps the label for a spinner and blocks taps.
  final bool isLoading;

  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final Color background = backgroundColor ?? context.appColors.brand;
    final Color foreground = foregroundColor ?? Colors.white;
    final double radius = context.appDimens.radiusMd;

    return SizedBox(
      width: double.infinity,
      height: context.appDimens.controlHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          disabledBackgroundColor: background.withValues(alpha: 0.5),
          disabledForegroundColor: foreground.withValues(alpha: 0.8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          textStyle: context.appText.button,
        ),
        child: isLoading
            ? SizedBox.square(
                dimension: context.appDimens.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: context.appDimens.strokeThick,
                  valueColor: AlwaysStoppedAnimation<Color>(foreground),
                ),
              )
            : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
