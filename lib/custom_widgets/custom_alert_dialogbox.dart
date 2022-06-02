import 'package:flutter/material.dart';
import 'package:help_on_needs/custom_widgets/button.dart';

import '../app_theme.dart';

const double _kWidth = 304;

class CustomAlertDialog {
  final String errorTitle;
  final String errorMessage;
  final String buttonTitle;
  final bool button2;
  final String? button2Title;
  final EdgeInsetsGeometry padding;
  final Function()? onPressed;
  final Function()? onPressedButton2;
  final bool useRootNavigator;
  const CustomAlertDialog({
    this.errorTitle = '',
    this.errorMessage = '',
    this.buttonTitle = '',
    this.onPressed,
    this.button2 = false,
    this.button2Title = '',
    this.padding = const EdgeInsets.all(24),
    this.onPressedButton2,
    this.useRootNavigator = true,
  });

  Future<void> showAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: useRootNavigator,
        barrierColor: Colors.black.withOpacity(0.4),
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Dialog(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ), //this right here
              child: SizedBox(
                width: _kWidth,
                child: Padding(
                  padding: padding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorTitle,
                        style: AppTheme.subHeading,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        errorMessage,
                        style: AppTheme.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: 120,
                        child: CustomButton(
                          title: buttonTitle,
                          ontap: onPressed ??
                              () {
                                Navigator.of(context).pop();
                              },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
