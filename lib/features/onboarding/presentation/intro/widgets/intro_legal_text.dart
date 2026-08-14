import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// The consent line under the welcome page's CTA.
///
/// The sentence stays one translatable string; the two policy names are
/// passed in separately and located inside it, so a translator can move them
/// without the underlines coming adrift.
class IntroLegalText extends StatelessWidget {
  const IntroLegalText({
    required this.text,
    required this.underlined,
    super.key,
  });

  final String text;

  /// Substrings of [text] the design underlines. Any that are absent are
  /// simply not marked up.
  final List<String> underlined;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = context.appText.caption.copyWith(
      color: context.appColors.onCanvasMuted,
    );

    return Text.rich(
      TextSpan(style: base, children: _spans(base)),
      textAlign: TextAlign.center,
      semanticsLabel: text,
    );
  }

  List<InlineSpan> _spans(TextStyle base) {
    final TextStyle marked = base.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: base.color,
    );

    // Walk the sentence once, splitting at whichever marked phrase comes next.
    final List<InlineSpan> spans = <InlineSpan>[];
    int cursor = 0;

    while (cursor < text.length) {
      int nextStart = text.length;
      String? nextPhrase;

      for (final String phrase in underlined) {
        if (phrase.isEmpty) continue;
        final int at = text.indexOf(phrase, cursor);
        if (at >= 0 && at < nextStart) {
          nextStart = at;
          nextPhrase = phrase;
        }
      }

      if (nextPhrase == null) {
        spans.add(TextSpan(text: text.substring(cursor)));
        break;
      }

      if (nextStart > cursor) {
        spans.add(TextSpan(text: text.substring(cursor, nextStart)));
      }
      spans.add(TextSpan(text: nextPhrase, style: marked));
      cursor = nextStart + nextPhrase.length;
    }

    return spans;
  }
}
