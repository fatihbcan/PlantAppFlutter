import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Centred progress indicator used while a section has nothing to show yet.
class AppLoader extends StatelessWidget {
  const AppLoader({this.color, super.key});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(context.appDimens.spaceXl),
        child: CircularProgressIndicator(
          strokeWidth: context.appDimens.strokeThick,
          color: color ?? context.appColors.brand,
        ),
      ),
    );
  }
}
