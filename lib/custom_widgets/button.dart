import 'package:flutter/material.dart';
import 'package:help_on_needs/app_theme.dart';

class CustomButton extends StatelessWidget {
  final Function()? ontap;
  final String title;
  final EdgeInsets padding;
  final TextStyle? style;
  const CustomButton({
    Key? key,
    this.ontap,
    this.padding = const EdgeInsets.all(8.0),
    this.style,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: ontap == null ? () {} : () => ontap!(),
        child: Ink(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: style ?? AppTheme.body.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
