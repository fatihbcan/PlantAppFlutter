import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/core/icons/app_icons.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';

/// Search input at the top of home.
///
/// The fill is deliberately not opaque: in the design the painted leaf behind
/// the field shows faintly through its right-hand end, and a solid white
/// would cut it off with a hard edge.
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

    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(dimens.radiusMd),
      borderSide: BorderSide(color: colors.outline),
    );

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (BuildContext context, TextEditingValue value, Widget? _) {
        return SizedBox(
          height: _height,
          child: TextField(
            controller: _controller,
            onChanged: widget.onChanged,
            textInputAction: TextInputAction.search,
            textAlignVertical: TextAlignVertical.center,
            style: context.appText.bodyLg.copyWith(color: colors.onCanvas),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: context.appText.bodyLg.copyWith(
                color: colors.onCanvasSubtle,
              ),
              filled: true,
              fillColor: colors.surface.withValues(alpha: 0.88),
              isDense: true,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  left: dimens.spaceLg,
                  right: dimens.spaceMd,
                ),
                child: AppIconView(
                  icon: AppIcon.search,
                  size: dimens.iconMd,
                  color: colors.onCanvasSubtle,
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: value.text.isEmpty
                  ? null
                  : IconButton(
                      icon: AppIconView(
                        icon: AppIcon.close,
                        size: dimens.iconSm,
                        color: colors.onCanvasSubtle,
                      ),
                      onPressed: () {
                        _controller.clear();
                        widget.onCleared();
                      },
                    ),
              contentPadding: EdgeInsets.zero,
              border: border,
              enabledBorder: border,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(dimens.radiusMd),
                borderSide: BorderSide(
                  color: colors.brand,
                  width: dimens.strokeThick,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static const double _height = 44;
}
