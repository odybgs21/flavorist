import 'package:flavorist/constant/colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.pinkPrimary,
  scaffoldBackgroundColor: AppColors.white,

  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.pinkPrimary,
    onPrimary: Colors.white,
    
    secondary: AppColors.pinkLight,
    onSecondary: Colors.white,
    
    error: Colors.red,
    onError: Colors.white,
    
    background: AppColors.white,
    onBackground: Colors.black,
    
    surface: AppColors.white,
    onSurface: Colors.black,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.pinkPrimary,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);
