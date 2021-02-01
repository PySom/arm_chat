import 'package:arm_chat/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'loading_button.dart';

class ExternalLogin extends StatelessWidget {
  final Function onGoogleSignIn;
  final bool isGoogleBusy;

  const ExternalLogin({
    this.onGoogleSignIn,
    this.isGoogleBusy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 45),
        Text(
          'or',
          style: kSmallTextStyle,
        ),
        SizedBox(
          height: 25,
        ),
        LoadingButton(
          isFlat: false,
          action: () async {
            await onGoogleSignIn();
          },
          isLoading: isGoogleBusy,
          color: kInputBorderColor,
          display: ExternalLoginContent(
            color: Colors.black,
            //please don't remove extra space
            text: 'Continue with Google     ',
            svgImage: 'google.svg',
          ),
        ),
      ],
    );
  }
}

class ExternalLoginContent extends StatelessWidget {
  final String svgImage;
  final String text;
  final Color color;
  const ExternalLoginContent({this.text, this.svgImage, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/$svgImage',
          height: 20,
          width: 20,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: buttonFont,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
