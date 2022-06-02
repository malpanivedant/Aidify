import 'package:flutter/material.dart';
import 'package:help_on_needs/app_theme.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Widget? textWidget;
  final bool circledRadio;
  final bool isCenteredAlign;
  final double iconSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget? selectedWidget;
  final Widget? unSelectedWidget;
  final Widget? disabledWidget;
  final bool isTextFontRegular;
  final Function()? onClicked;
  final CrossAxisAlignment? variableCrossAxisAlignment;

  const CustomRadioButton(
      {Key? key,
      required this.label,
      this.isSelected = false,
      this.textWidget,
      this.circledRadio = false,
      this.isCenteredAlign = false,
      this.iconSize = 20,
      this.horizontalPadding = 24,
      this.verticalPadding = 24,
      this.selectedWidget,
      this.unSelectedWidget,
      this.disabledWidget,
      this.onClicked,
      this.isTextFontRegular = false,
      this.variableCrossAxisAlignment})
      : super(key: key);

  Widget _getButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Ink(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              variableCrossAxisAlignment ?? CrossAxisAlignment.start,
          mainAxisAlignment: isCenteredAlign
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [_getIcon(context), Expanded(child: _getText(context))],
        ),
      ),
    );
  }

  Widget _getText(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.only(left: 8),
        child: textWidget ??
            Text(
              label,
              style: isTextFontRegular ? AppTheme.subHeading : AppTheme.body,
            ));
  }

  Widget _getIcon(BuildContext context) {
    // Replace containers with svg picture assets when avialable
    return isSelected
        ? circledRadio
            ? selectedWidget ??
                Ink(
                  child: Icon(
                    Icons.radio_button_checked,
                    color: Colors.red,
                    size: iconSize,
                  ),
                  height: 20,
                  width: 20,
                )
            : disabledWidget ??
                Ink(
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 14,
                  ),
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                )
        : unSelectedWidget ??
            Ink(
              height: 20,
              width: 20,
              child: Icon(
                Icons.radio_button_off,
                color: Colors.red,
                size: iconSize,
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onClicked, child: _getButton(context));
  }
}
