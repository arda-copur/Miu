import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  //Custom Colors
  static const Color primary2 = Color(0xFFD48CF6);
  static const Color primary3 = Color(0xFFE9C5FB);
  static const Color primary5 = Color(0xFFFFDF92);
  static const Color primary6 = Color(0xFFFFEFC9);

  static const Color accent1 = Color(0xFF0084F4);
  static const Color accent2 = Color(0xFF4EAEFF);
  static const Color accent3 = Color(0xFFA6D6FF);

  static const Color warningColor = Color(0xFFFF647C);
  static const Color warning2 = Color(0xFFFF98AB);
  static const Color warning3 = Color(0xFFFFCBD3);

  static const Color neutral1 = Color(0xFFF2994A);
  static const Color neutral2 = Color(0xFFF6BB86);
  static const Color appNeutral = Color(0xFFFBDDC3);

  static const Color appBlack = Color(0xFF151522);
  static const Color gray2 = Color(0xFFE0E0E0);

  static const Color customBlue = Color(0xFF3D639D);
  static const Color white = Color(0xFFFFFFFF);

  //Shadows
  static List<BoxShadow> keenShadow = const [
    BoxShadow(
      color: AppTheme.appBlack,
      spreadRadius: 0.2,
      blurRadius: 1,
    )
  ];

  static List<BoxShadow> headTextShadow = const [
    BoxShadow(
      color: AppTheme.appBlack,
      spreadRadius: 1,
      blurRadius: 1,
    )
  ];

  static List<BoxShadow> textShadow = const [
    BoxShadow(
      color: AppTheme.appBlack,
      spreadRadius: 1,
      blurRadius: 1,
    )
  ];

  //Borders
  static final outLineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
  );
  static final focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: AppTheme.primary6),
  );

  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: Colors.red,
    ),
  );

  //Paddings

  /// [minPadding] is 4
  static const EdgeInsets minPadding = EdgeInsets.all(4);

  /// [smallPadding] is 8
  static const EdgeInsets smallPadding = EdgeInsets.all(8);

  /// [primaryPadding] is 12
  static const EdgeInsets primaryPadding = EdgeInsets.all(12);

  /// [highPadding] is 16
  static const EdgeInsets highPadding = EdgeInsets.all(16);

  /// [extraPadding] is 20
  static const EdgeInsets extraPadding = EdgeInsets.all(20);

  //Border Radius

  /// [smallCircular] is 4
  static final BorderRadius smallCircular = BorderRadius.circular(4);

  /// [primaryCircular] is 8
  static final BorderRadius primaryCircular = BorderRadius.circular(8);

  /// [extraCircular] is 12
  static final BorderRadius extraCircular = BorderRadius.circular(12);

  /// [hugeCircular] is 20
  static final BorderRadius hugeCircular = BorderRadius.circular(20);

  static final ThemeData appTheme = ThemeData(
    appBarTheme: const AppBarTheme(backgroundColor: appNeutral),
    scaffoldBackgroundColor: appNeutral,
    cardTheme: CardTheme(
      color: appNeutral,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: primaryCircular),
    ),
    buttonBarTheme: const ButtonBarThemeData(buttonPadding: minPadding),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: appNeutral),
    primarySwatch: const MaterialColor(0xFF888595, {
      50: appNeutral,
      100: appNeutral,
      200: appNeutral,
      300: appNeutral,
      400: appNeutral,
      500: appNeutral,
      600: appNeutral,
      700: appNeutral,
      800: appNeutral,
      900: appNeutral,
    }),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    inputDecorationTheme: InputDecorationTheme(
      border: AppTheme.outLineBorder,
      focusedBorder: AppTheme.focusedBorder,
      errorBorder: AppTheme.errorBorder,
    ),
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: primaryCircular),
    ),
    listTileTheme: ListTileThemeData(
      shape: RoundedRectangleBorder(borderRadius: primaryCircular),
      iconColor: AppTheme.appBlack,
      textColor: AppTheme.appBlack,
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      displayMedium: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      displayLarge: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      headlineSmall: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      headlineMedium: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      headlineLarge: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      labelSmall: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      labelMedium: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
      labelLarge: TextStyle(
        color: appBlack,
        fontFamily: 'OpenSans',
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: smallCircular),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            color: appBlack,
            shadows: headTextShadow,
            fontFamily: "OpenSans",
          ),
        ),
      ),
    ),
    iconTheme: IconThemeData(
      shadows: textShadow,
    ),
  );
}
