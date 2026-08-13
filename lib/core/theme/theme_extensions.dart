import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/app_colors.dart';
import 'package:hubx_flutter_case/core/theme/app_dimens.dart';
import 'package:hubx_flutter_case/core/theme/app_typography.dart';

/// Terse access to the theme extensions from any widget.
extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  AppTypography get appText => Theme.of(this).extension<AppTypography>()!;

  /// Dimens shrink on short viewports so onboarding still fits without
  /// scrolling on a small phone.
  AppDimens get appDimens {
    final AppDimens base = Theme.of(this).extension<AppDimens>()!;
    return MediaQuery.sizeOf(this).height < _compactHeightBreakpoint
        ? AppDimens.compact
        : base;
  }

  static const double _compactHeightBreakpoint = 700;
}
