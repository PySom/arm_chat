import 'package:flutter/material.dart';

//primitives
const double bigFont = 30.0;
const double semiBigFont = 25.0;
const double mediumFont = 22.0;
const double defaultFont = 20.0;
const double inputFont = 22.0;
const double buttonFont = 18.0;
const double smallFont = 17.0;
const double littleFont = 15.0;
const double termsFont = 13.0;
const String kHeroIconTag = 'iconTag';
const String kHeroLocationTag = 'locationTag';

//colors
const Color kWhiteColor = Colors.white;
const Color kPrimaryColor = Color(0xFF13184D);
const Color kTextButtonColor = Color(0xFF1D2256);
const Color kAccentColor = Color(0xFFFFB600);
const Color kInputBorderColor = Color(0xFFD6D8DE);
const Color kGreenColor = Color(0xFF00C488);
const Color kPickupColor = Color(0xFF00D090);
const Color kDestinationColor = Color(0xFFE50000);
const Color kDividerColor = Color(0xFFD6D8DE);
const Color kSmallFontColor = Color(0xFFB7BAC7);
const Color kBottomTopBarColor = Color(0xFF4A4A4A);
const Color kHomeColor = Color(0xFFF8F8F8);
const Color kHomeTextColor = Color(0xFFB7BAC7);
const Color kLocationDividerColor = Color(0xFF707070);

//styles
const TextStyle kDefaultFontStyle = TextStyle(
  fontSize: defaultFont,
  color: kPrimaryColor,
  fontWeight: FontWeight.w400,
);

const TextStyle kTextButtonStyle = TextStyle(
  fontSize: buttonFont,
  color: kTextButtonColor,
  fontWeight: FontWeight.w500,
);

const TextStyle kInputTextStyle = TextStyle(
  fontSize: defaultFont,
  color: kSmallFontColor,
  fontWeight: FontWeight.w400,
);

const TextStyle kSmallTextStyle = TextStyle(
  fontSize: smallFont,
  color: kSmallFontColor,
);

const TextStyle kTermsTextStyle = TextStyle(
  fontSize: termsFont,
  color: kSmallFontColor,
);

//widgets
const SizedBox kAppSpacingVertical = SizedBox(
  height: 30,
);
const SizedBox kAppInputSpacingVertical = SizedBox(
  height: 20,
);
//sizes
const Size kTextButtonSize = Size(double.infinity, 0);
//padding
const kButtonPadding = EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0);
const kAppPadding = EdgeInsets.fromLTRB(15, 10, 15, 30);
const kBottomSheetPadding = EdgeInsets.fromLTRB(30, 10, 30, 5);
const kAppBarIconPadding = EdgeInsets.only(left: 20, right: 5);
const kAppBarActionPadding = EdgeInsets.only(right: 20);

//Radius
const kBoxRadius = BorderRadius.all(
  Radius.circular(10),
);
