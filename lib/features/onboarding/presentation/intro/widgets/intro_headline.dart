import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Intro headline with one emphasised phrase, as in the design.
///
/// Both arguments are plain strings so the widget carries no knowledge of
/// which page it is rendering.
class IntroHeadline extends StatelessWidget {
  const IntroHeadline({required this.text, this.highlight, super.key});

  final String text;

  /// Substring of [text] to render in the heavy weight. Ignored when it is
  /// null or absent from [text].
  final String? highlight;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = context.appText.displayLg.copyWith(
      color: context.appColors.onCanvas,
    );
    final TextStyle emphasised = base.copyWith(fontWeight: FontWeight.w800);

    final int start = (highlight == null || highlight!.isEmpty)
        ? -1
        : text.indexOf(highlight!);

    if (start < 0) {
      return Text(text, style: base);
    }

    final int end = start + highlight!.length;
    return Text.rich(
      TextSpan(
        style: base,
        children: <TextSpan>[
          TextSpan(text: text.substring(0, start)),
          TextSpan(text: text.substring(start, end), style: emphasised),
          TextSpan(text: text.substring(end)),
        ],
      ),
    );
  }
}
