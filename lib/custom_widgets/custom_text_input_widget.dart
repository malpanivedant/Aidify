import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_on_needs/app_theme.dart';

const Color color = Colors.grey;

class CustomTextInputWidget extends StatelessWidget {
  final String? label;
  final String? errorLabel;
  final String? placeHolder;
  final String? errorText;
  final EdgeInsetsGeometry padding;
  final TextEditingController? textEditingController;
  final bool valid;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String)? onChanged;
  final Color backgroundColor;
  final bool isEnabled;
  final bool showCrossIcon;
  final FocusNode? focusNode;
  final Function()? onClearClick;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;

  const CustomTextInputWidget({
    Key? key,
    this.label,
    this.placeHolder,
    this.errorText,
    this.textEditingController,
    this.valid = true,
    this.padding = const EdgeInsets.only(left: 30, right: 34),
    this.errorLabel,
    this.textInputFormatter,
    this.onChanged,
    this.backgroundColor = color,
    this.isEnabled = true,
    this.showCrossIcon = false,
    this.focusNode,
    this.onClearClick,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: focusNode,
            enabled: isEnabled,
            controller: textEditingController,
            autofocus: false,
            maxLines: maxLines,
            onChanged: onChanged,
            style: AppTheme.body,
            inputFormatters: textInputFormatter,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: valid == false ? Colors.red : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: valid == false ? Colors.red : Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide: BorderSide(
                  color: valid == false ? Colors.red : Colors.transparent,
                ),
              ),
              suffixIcon: suffixIcon ??
                  ((valid == false &&
                          textEditingController != null &&
                          textEditingController!.text.isNotEmpty &&
                          showCrossIcon)
                      ? IconButton(
                          icon: const Icon(Icons.clear_outlined),
                          iconSize: 16,
                          color: Colors.red,
                          onPressed: onClearClick,
                        )
                      : null),
              filled: true,
              fillColor: backgroundColor,
              hintText: placeHolder,
              hintStyle: AppTheme.body,
              label: valid == false
                  ? Text(errorLabel ?? label ?? "",
                      style: AppTheme.body
                          .copyWith(color: Colors.red, fontSize: 12))
                  : Text(label ?? "",
                      style: AppTheme.body.copyWith(fontSize: 12)),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
          ),
          Offstage(
              offstage: !(valid == false &&
                  errorText != null &&
                  errorText!.isNotEmpty),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 2,
                ),
                child: Text(
                  errorText ?? "",
                  style: AppTheme.body,
                ),
              ))
        ],
      ),
    );
  }
}
