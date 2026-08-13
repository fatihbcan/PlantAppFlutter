import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/assets/app_assets.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Intro headline with one emphasised phrase, as in the design.
///
/// The emphasis is two things at once: a heavier weight, and the design's
/// hand-drawn stroke sitting under the phrase. The stroke is drawn inside a
/// [WidgetSpan] so it tracks the phrase wherever the line breaks put it,
/// rather than being positioned against the headline box.
///
/// Both arguments are plain strings so the widget carries no knowledge of
/// which page it is rendering.
class IntroHeadline extends StatelessWidget {
  const IntroHeadline({
    required this.text,
    this.highlight,
    this.isHighlightUnderlined = true,
    super.key,
  });

  final String text;

  /// Substring of [text] to emphasise. Ignored when it is null or absent
  /// from [text].
  final String? highlight;

  /// Whether the emphasis also carries the hand-drawn stroke. The welcome
  /// screen emphasises the product name with weight alone.
  final bool isHighlightUnderlined;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = context.appText.displayLg.copyWith(
      color: context.appColors.onCanvas,
    );

    final int start = (highlight == null || highlight!.isEmpty)
        ? -1
        : text.indexOf(highlight!);

    if (start < 0) {
      return Text(text, style: base);
    }

    final int end = start + highlight!.length;
    final TextStyle emphasised = base.copyWith(fontWeight: FontWeight.w800);
    final String phrase = text.substring(start, end);

    return Text.rich(
      TextSpan(
        style: base,
        children: <InlineSpan>[
          TextSpan(text: text.substring(0, start)),
          if (isHighlightUnderlined)
            WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: _UnderlinedPhrase(text: phrase, style: emphasised),
            )
          else
            TextSpan(text: phrase, style: emphasised),
          TextSpan(text: text.substring(end)),
        ],
      ),
      // The phrase is a single box inside the paragraph, so it is read as one
      // run of text either way; spelling it out keeps the announcement whole.
      semanticsLabel: text,
    );
  }
}

/// The emphasised phrase with the stroke drawn beneath it.
class _UnderlinedPhrase extends StatelessWidget {
  const _UnderlinedPhrase({required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final double fontSize = style.fontSize ?? 0;

    // The stroke hangs below the baseline without adding to the line box, so
    // the headline's leading is unchanged whether a phrase is emphasised.
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Text(text, style: style),
        Positioned(
          left: 0,
          right: 0,
          bottom: -fontSize * _strokeDropFactor,
          child: Image.asset(
            AppAssets.headlineUnderline,
            height: fontSize * _strokeHeightFactor,
            fit: BoxFit.fill,
            excludeFromSemantics: true,
            color: style.color,
          ),
        ),
      ],
    );
  }

  static const double _strokeHeightFactor = 0.28;
  static const double _strokeDropFactor = 0.08;
}
