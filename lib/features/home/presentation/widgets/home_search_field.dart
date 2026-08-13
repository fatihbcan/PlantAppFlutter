import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Search input at the top of home.
///
/// Stateful only to own its [TextEditingController]; the query itself lives
/// in [HomeState].
class HomeSearchField extends StatefulWidget {
  const HomeSearchField({
    required this.hintText,
    required this.onChanged,
    required this.onCleared,
    super.key,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback onCleared;

  @override
  State<HomeSearchField> createState() => _HomeSearchFieldState();
}

class _HomeSearchFieldState extends State<HomeSearchField> {
  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final dimens = context.appDimens;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (BuildContext context, TextEditingValue value, Widget? _) {
        return TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          textInputAction: TextInputAction.search,
          style: context.appText.bodyMd.copyWith(color: colors.onCanvas),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: context.appText.bodyMd.copyWith(
              color: colors.onCanvasSubtle,
            ),
            filled: true,
            fillColor: colors.surface,
            prefixIcon: Icon(
              Icons.search_rounded,
              size: dimens.iconMd,
              color: colors.onCanvasSubtle,
            ),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(Icons.close_rounded, size: dimens.iconSm),
                    color: colors.onCanvasSubtle,
                    onPressed: () {
                      _controller.clear();
                      widget.onCleared();
                    },
                  ),
            contentPadding: EdgeInsets.symmetric(vertical: dimens.spaceMd),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(dimens.radiusMd),
              borderSide: BorderSide(color: colors.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(dimens.radiusMd),
              borderSide: BorderSide(color: colors.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(dimens.radiusMd),
              borderSide: BorderSide(
                color: colors.brand,
                width: dimens.strokeThick,
              ),
            ),
          ),
        );
      },
    );
  }
}
