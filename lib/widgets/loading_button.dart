import 'package:arm_chat/utils/constants.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final Widget display;
  final Function action;
  final Color color;
  final bool isFlat;
  LoadingButton({
    this.display,
    this.isLoading,
    this.action,
    this.color = kTextButtonColor,
    this.isFlat = true,
  });

  Widget _spinner(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: 2,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
    );
  }

  void _showFlush(BuildContext context, String message) {
    Flushbar(
      backgroundColor: kPrimaryColor,
      message: message,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  Future<void> _onPressed(BuildContext context) async {
    try {
      await action();
    } catch (ex) {
      _showFlush(context, ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isFlat
        ? TextButton(
            onPressed: () async {
              await _onPressed(context);
            },
            child: isLoading ? _spinner(context) : display,
          )
        : OutlinedButton(
            onPressed: () async {
              await _onPressed(context);
            },
            child: isLoading ? _spinner(context) : display,
          );
  }
}
