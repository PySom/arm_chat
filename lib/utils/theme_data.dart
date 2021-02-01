import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData myThemeData(BuildContext context) {
  return ThemeData(
    fontFamily: "Rubik",
    primaryColor: kPrimaryColor,
    accentColor: kAccentColor,
    buttonColor: kAccentColor,
    scaffoldBackgroundColor: kWhiteColor,
    textTheme: Theme.of(context).primaryTextTheme.copyWith(
          bodyText2: kDefaultFontStyle,
        ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      labelStyle: kInputTextStyle.copyWith(height: 0.3),
      hintStyle: kInputTextStyle,
      contentPadding: EdgeInsets.all(5),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kInputBorderColor, width: 1),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kInputBorderColor, width: 1),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      padding: MaterialStateProperty.all(kButtonPadding),
      minimumSize: MaterialStateProperty.all(kTextButtonSize),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(kTextButtonStyle),
        backgroundColor: MaterialStateProperty.all(kAccentColor),
        foregroundColor: MaterialStateProperty.all(kTextButtonColor),
        minimumSize: MaterialStateProperty.all(kTextButtonSize),
        padding: MaterialStateProperty.all(kButtonPadding),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
        ),
      ),
    ),
    canvasColor: Colors.transparent,
    iconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      elevation: 0,
      color: kWhiteColor,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
