import 'package:flutter/material.dart';
import 'colors_manager.dart';

import 'values_manager.dart';

ThemeData getAppTheme(){



    return ThemeData(
      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primaryLight,
      disabledColor: AppColors.secondaryFontColor,
      splashColor: AppColors.primary,
      errorColor: Colors.red,



      // elevatedButtonTheme: ElevatedButtonThemeData(
      //   style: ElevatedButton.styleFrom(
      //     primary: AppColors.primary,
      //     textStyle: regularTextStyle(color: AppColors.secondaryFontColor,fontSize:AppSize.s12),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(AppSize.s12),
      //     ),
      //   ),
      // ),
      //
      // textTheme: TextTheme(
      //   displayLarge:boldTextStyle(color: ColorsManager.primaryFontColor,fontSize: FontSizeManager.s10) ,
      //   headlineMedium: regularTextStyle(color: ColorsManager.primaryFontColor),
      //   titleSmall: regularTextStyle(color: ColorsManager.secondaryFontColor),
      //   bodySmall: regularTextStyle(color: ColorsManager.secondaryFontColor),
      //
      // ),

      inputDecorationTheme:  InputDecorationTheme(
        contentPadding:  const EdgeInsets.all(AppSize.s8),
        enabledBorder: OutlineInputBorder(
          borderSide:  const BorderSide(color: AppColors.secondaryFontColor,width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s1_5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.activeColor,width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s1_5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.error,width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s1_5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.activeColor,width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s1_5),
        ),

      ),

    );

}