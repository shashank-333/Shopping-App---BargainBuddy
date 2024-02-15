import 'package:flutter/material.dart';

class AppTheme {
  static Color primaryColor = Colors.amber;
  // static final ThemeData light = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Colors.amber,
  //   scaffoldBackgroundColor: Colors.white,
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: Colors.amber[100],
  //     selectedItemColor: Colors.amber[900],
  //     unselectedItemColor: Colors.grey[600],
  //   ),
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: Colors.amber[300],
  //     titleTextStyle: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 20,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   cardTheme: CardTheme(
  //     color: Colors.amber[50],
  //     elevation: 4,
  //     margin: const EdgeInsets.all(8),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //   ),
  //   colorScheme: ColorScheme.fromSwatch(
  //     primarySwatch: Colors.amber,
  //     accentColor: Colors.amberAccent,
  //   ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Colors.amber[600],
  //     foregroundColor: Colors.white,
  //   ),
  //   dividerTheme: DividerThemeData(
  //     color: Colors.grey[400],
  //     thickness: 1,
  //     space: 8,
  //   ),
  //   bottomAppBarTheme: BottomAppBarTheme(
  //     color: Colors.amber[200],
  //     shape: const CircularNotchedRectangle(),
  //   ),
  //   tabBarTheme: TabBarTheme(
  //     labelColor: Colors.amber[900],
  //     unselectedLabelColor: Colors.grey[600],
  //     indicator: const UnderlineTabIndicator(
  //       borderSide: BorderSide(
  //         // color: Colors.amber[900],
  //         width: 2,
  //       ),
  //     ),
  //   ),
  //   sliderTheme: SliderThemeData(
  //     activeTrackColor: Colors.amber[700],
  //     inactiveTrackColor: Colors.amber[100],
  //     thumbColor: Colors.amber[600],
  //     overlayColor: Colors.amber[100]!.withOpacity(0.4),
  //     valueIndicatorColor: Colors.amber[900],
  //     valueIndicatorTextStyle: const TextStyle(
  //       color: Colors.white,
  //     ),
  //   ),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: Colors.amber[300],
  //     textTheme: ButtonTextTheme.primary,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //   ),
  //   // Other colors
  //   primaryColorLight: Colors.amber[100],
  //   primaryColorDark: Colors.amber[800],
  //   hintColor: Colors.amberAccent,
  //   backgroundColor: Colors.white,
  //   errorColor: Colors.red[600],
  // );
  //
  // static final ThemeData dark = ThemeData(
  //   brightness: Brightness.dark,
  //   primaryColor: Colors.amber,
  //   scaffoldBackgroundColor: Colors.grey[900],
  //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //     backgroundColor: Colors.grey[800],
  //     selectedItemColor: Colors.amber[300],
  //     unselectedItemColor: Colors.grey[400],
  //   ),
  //   appBarTheme: AppBarTheme(
  //     backgroundColor: Colors.grey[850],
  //     titleTextStyle: const TextStyle(
  //       color: Colors.white,
  //       fontSize: 20,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   ),
  //   cardTheme: CardTheme(
  //     color: Colors.grey[700],
  //     elevation: 4,
  //     margin: const EdgeInsets.all(8),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //   ),
  //   colorScheme: ColorScheme.fromSwatch(
  //     primarySwatch: Colors.amber,
  //     accentColor: Colors.amberAccent,
  //     brightness: Brightness.dark,
  //   ),
  //   floatingActionButtonTheme: FloatingActionButtonThemeData(
  //     backgroundColor: Colors.amber[300],
  //     foregroundColor: Colors.black,
  //   ),
  //   dividerTheme: DividerThemeData(
  //     color: Colors.grey[500],
  //     thickness: 1,
  //     space: 8,
  //   ),
  //   bottomAppBarTheme: BottomAppBarTheme(
  //     color: Colors.grey[800],
  //     shape: const CircularNotchedRectangle(),
  //   ),
  //   tabBarTheme: TabBarTheme(
  //     labelColor: Colors.amber[300],
  //     unselectedLabelColor: Colors.grey[400],
  //     indicator: const UnderlineTabIndicator(
  //       borderSide: BorderSide(
  //         // color: Colors?.amber[300],
  //         width: 2,
  //       ),
  //     ),
  //   ),
  //   sliderTheme: SliderThemeData(
  //     activeTrackColor: Colors.amber[300],
  //     inactiveTrackColor: Colors.grey[800],
  //     thumbColor: Colors.amber[300],
  //     overlayColor: Colors.amber[300]!.withOpacity(0.4),
  //     valueIndicatorColor: Colors.amber[300],
  //     valueIndicatorTextStyle: const TextStyle(
  //       color: Colors.black,
  //     ),
  //   ),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: Colors.amber[300],
  //     textTheme: ButtonTextTheme.primary,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //   ),
  //   // Other colors
  //   primaryColorLight: Colors.amber[100],
  //   primaryColorDark: Colors.amber[800],
  //   hintColor: Colors.amberAccent,
  //   backgroundColor: Colors.grey[900],
  //   errorColor: Colors.red[600],
  // );

  /// -------------------------- Light Theme  -------------------------------------------- ///

  static final ThemeData light = ThemeData(
    /// Brightness
    brightness: Brightness.light,

    /// Scaffold and Background color
    // scaffoldBackgroundColor: const Color(0xFFF0FCF4),
    scaffoldBackgroundColor: Colors.amber[50],
    canvasColor: Colors.transparent,

    ///Bottom Navigation Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
      selectedIconTheme: IconThemeData(color: primaryColor),
      unselectedLabelStyle: TextStyle(
          color: Colors.grey[400], fontFamily: "Brandon-bold", fontSize: 10),
      selectedLabelStyle: const TextStyle(
          color: Colors.black, fontFamily: "Brandon-bold", fontSize: 12),
    ),

    /// AppBar Theme
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.amber[300]!.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.black54),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: "Brandon-bold",
          letterSpacing: 0.27,
        ),
        actionsIconTheme: IconThemeData(color: Colors.black54)),

    /// Card Theme
    cardTheme: CardTheme(
      color: Colors.amber[100],
      elevation: 4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ), //   cardColor: const Color(0xffffffff),

    /// Colorscheme
    colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        background: Colors.white),

    snackBarTheme: const SnackBarThemeData(actionTextColor: Colors.white),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppTheme.primaryColor,
        splashColor: const Color(0xffeeeeee).withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: AppTheme.primaryColor,
        hoverColor: AppTheme.primaryColor,
        foregroundColor: const Color(0xffeeeeee)),

    /// Divider Theme
    dividerTheme:
        const DividerThemeData(color: Color(0xffdddddd), thickness: 1),
    dividerColor: const Color(0xffdddddd),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xffeeeeee), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color(0Xff3367d6),
              Color(0Xff3367d6),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppTheme.primaryColor,
      inactiveTrackColor: AppTheme.primaryColor.withAlpha(140),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: AppTheme.primaryColor,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Color(0xffeeeeee),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      checkColor: MaterialStateProperty.all(const Color(0xffffffff)),
      fillColor: MaterialStateProperty.all(AppTheme.primaryColor),
    ),
    switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.selected)
                ? AppTheme.primaryColor
                : Colors.white)),

    /// Button Theme
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor, // Background color of the button
      textTheme: ButtonTextTheme.primary, // Text color of the button
    ),

    /// Other Colors
    splashColor: Colors.white.withAlpha(100),
    indicatorColor: const Color(0xffeeeeee),
    highlightColor: const Color(0xffeeeeee),
  );

  /// -------------------------- Dart Theme  -------------------------------------------- ///

  static final ThemeData dark = ThemeData.dark().copyWith(
    /// Scaffold and Background color
    scaffoldBackgroundColor: const Color(0xff000000),
    canvasColor: Colors.transparent,

    /// AppBar Theme
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: primaryColor),
      backgroundColor: const Color(0xff262729),
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.27),
      iconTheme: IconThemeData(color: primaryColor),
    ),

    ///Bottom Navigation Theme
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      // backgroundColor: const Color(0xff262729),
      unselectedIconTheme: const IconThemeData(color: Colors.white),
      selectedIconTheme: IconThemeData(color: primaryColor),
      unselectedLabelStyle: const TextStyle(
          color: Colors.white, fontFamily: "Brandon-bold", fontSize: 10),
      selectedLabelStyle: const TextStyle(
          color: Colors.black, fontFamily: "Brandon-bold", fontSize: 12),
    ),

    /// Card Theme
    cardTheme: const CardTheme(color: Color(0xff1b1b1c)),
    cardColor: const Color(0xff1b1b1c),

    inputDecorationTheme: const InputDecorationTheme(),

    /// Colorscheme
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      background: const Color(0xff262729),
      onBackground: const Color(0xFFD7D7D7),
      brightness: Brightness.dark,
    ),

    /// Divider Color
    dividerTheme:
        const DividerThemeData(color: Color(0xff393A41), thickness: 1),
    dividerColor: const Color(0xff393A41),

    /// Floating Action Theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppTheme.primaryColor,
        splashColor: Colors.white.withAlpha(100),
        highlightElevation: 8,
        elevation: 4,
        focusColor: AppTheme.primaryColor,
        hoverColor: AppTheme.primaryColor,
        foregroundColor: Colors.white),

    /// Bottom AppBar Theme
    bottomAppBarTheme:
        const BottomAppBarTheme(color: Color(0xff464c52), elevation: 2),

    /// Tab bar Theme
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.white,
      labelColor: AppTheme.primaryColor,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: const TextStyle(color: Colors.white),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0),
      ),
    ),

    /// Slider Theme
    sliderTheme: SliderThemeData(
      activeTrackColor: AppTheme.primaryColor,
      inactiveTrackColor: AppTheme.primaryColor.withAlpha(100),
      trackShape: const RoundedRectSliderTrackShape(),
      trackHeight: 4.0,
      thumbColor: AppTheme.primaryColor,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
      tickMarkShape: const RoundSliderTickMarkShape(),
      inactiveTickMarkColor: Colors.red[100],
      valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
      valueIndicatorTextStyle: const TextStyle(
        color: Colors.white,
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor, // Background color of the button
      textTheme: ButtonTextTheme.primary, // Text color of the button
    ),

    ///Other Color
    indicatorColor: Colors.white,
    disabledColor: const Color(0xffa3a3a3),
    highlightColor: const Color(0xff47484b),
    splashColor: Colors.white.withAlpha(100),
  );
}
