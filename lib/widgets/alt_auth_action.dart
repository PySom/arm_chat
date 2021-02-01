import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AltAuthAction extends StatelessWidget {
  final String leadingText;
  final String actionText;
  final TextStyle defaultStyle;
  final TextStyle leadingStyle;
  final TextStyle actionStyle;
  final TextAlign textAlign;
  final List<TextSpan> children;
  final Function onTap;
  const AltAuthAction({
    this.onTap,
    this.actionText,
    this.leadingText,
    this.actionStyle,
    this.defaultStyle,
    this.leadingStyle,
    this.children,
    this.textAlign,
  });
  @override
  Widget build(BuildContext context) {
    return RichText(
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textAlign: textAlign ?? TextAlign.center,
      text: TextSpan(
        style: defaultStyle,
        children: children ??
            [
              TextSpan(
                text: leadingText,
                style: leadingStyle,
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onTap,
                text: actionText,
                style: actionStyle,
              ),
            ],
      ),
    );
  }
}
