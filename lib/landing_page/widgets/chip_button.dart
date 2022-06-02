import 'package:flutter/material.dart';

import '../../app_theme.dart';

const _kBorderRadius20 = BorderRadius.all(Radius.circular(20));
const _maxLines = 1;

class CustomChipButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Widget? titleWidget;
  final bool isSelected;
  final double? height;
  final ValueChanged<bool>? onSelected;
  final bool showShadow;
  final bool isGreybackground;
  final bool isLighterGreyColor;
  final Color? buttonBackgroundColor;
  final EdgeInsets padding;

  const CustomChipButton({
    Key? key,
    this.title = "",
    this.onPressed,
    this.isSelected = true,
    this.onSelected,
    this.titleWidget,
    this.height,
    this.showShadow = false,
    this.isGreybackground = true,
    this.isLighterGreyColor = false,
    this.buttonBackgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  }) : super(key: key);

  Widget _buildButton(BuildContext context) {
    return Ink(
      padding: padding,
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.red,
              borderRadius: _kBorderRadius20,
              boxShadow: showShadow
                  ? [
                      const BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ]
                  : [],
            )
          : BoxDecoration(
              color: buttonBackgroundColor ?? Colors.grey.shade300,
              borderRadius: _kBorderRadius20,
              boxShadow: showShadow
                  ? [
                      const BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ]
                  : [],
            ),
      child: SizedBox(
        height: height,
        child: Center(
          child: titleWidget ??
              Text(
                title,
                style: AppTheme.body.copyWith(
                  color: isSelected ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: _maxLines,
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: _buildButton(context),
      onTap: onPressed,
    );
  }
}
