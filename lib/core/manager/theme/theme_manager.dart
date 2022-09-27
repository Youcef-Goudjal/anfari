import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._init();
  static ThemeManager get instance => _instance;

  static const primaryColor = Color(0Xff15997e);
  static const secondaryColor = Color(0XffFFE0AC);

  ThemeManager._init();

  ThemeData get darkTheme => ThemeData.dark();
  ThemeData get lightTheme => ThemeData.light(
        useMaterial3: true,
      ).copyWith(
        textTheme: GoogleFonts.cairoTextTheme().copyWith(
          headline1: GoogleFonts.cairoTextTheme().headline1!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 35.sp,
                color: Colors.white,
                letterSpacing: 0.23.w,
              ),
          headline2: GoogleFonts.cairoTextTheme().headline2!.copyWith(
                fontSize: 18.sp,
                color: Colors.white,
                letterSpacing: 0.23.w,
                fontWeight: FontWeight.normal,
              ),
          headline3: GoogleFonts.cairoTextTheme().headline3!.copyWith(
                fontSize: 14.sp,
                color: Colors.white,
                letterSpacing: 0.23.w,
              ),
          headline4: GoogleFonts.cairoTextTheme().headline2!.copyWith(
                fontSize: 37.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
          headline5: GoogleFonts.cairoTextTheme().headline2!.copyWith(
                fontSize: 19.sp,
                color: const Color(0xffCCCCCC),
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: primaryColor,
            elevation: 0,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xffF8F8F8).withOpacity(0.7),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: const BorderSide(color: primaryColor),
          ),
          prefixIconColor: const Color(0xffB1B1B1),
          prefixStyle: GoogleFonts.cairo().copyWith(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          isDense: true,
        ),
        //scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.black,
          error: Color(0xFFB00020),
          onError: Color(0xFFFFFFFF),
          background: Color(0xFFEBEEF0),
          onBackground: Color(0xFF121212),
          surface: Color(0xFFF5F6F7),
          onSurface: Color(0xFF090909),
        ),
      );
}
