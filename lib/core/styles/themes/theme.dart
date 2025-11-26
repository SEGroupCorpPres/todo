import 'package:todo/core/core.dart';

class AppTheme {
  AppBarTheme appBarTheme(BuildContext context) => AppBarTheme(
    titleTextStyle: TextStyle(
      fontFamily: 'Manrope',
      fontSize: AppSizes.screenTitle.sp,
      color: AppColors.mainTextColor,
      fontWeight: FontWeight.w400,
    ),
    backgroundColor: Colors.transparent,
    actionsIconTheme: IconThemeData(color: AppColors.white, size: 24.sp),
  );

  ThemeData appTheme(BuildContext context) => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.mainColor,
    appBarTheme: appBarTheme(context),
    listTileTheme: ListTileThemeData(
      titleTextStyle: TextStyle(
        fontSize: AppSizes.listFS.sp,
        color: AppColors.todoLightText,
        fontFamily: 'Manrope',
      ),
      subtitleTextStyle: TextStyle(
        fontSize: AppSizes.listSubtitleFS.sp,
        color: AppColors.todoLightText,
        fontFamily: 'Manrope',
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontSize: AppSizes.listFS.sp,
        color: AppColors.todoLightText,
        fontFamily: 'Manrope',
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.mainButtonBg,
        foregroundColor: AppColors.mainTextColor,
        iconSize: 24.sp,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppSizes.btnBorderRadius),
        ),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 18.sp,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(fontFamily: 'Manrope', fontSize: 12.sp, color: Colors.white),
      labelMedium: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 15.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 16.sp,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        height: 1,
        letterSpacing: -.02,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    scaffoldBackgroundColor: AppColors.scaffoldLightBg,
    inputDecorationTheme: InputDecorationTheme(
      constraints: BoxConstraints(minHeight: 60.h),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppColors.grey, width: 1.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: CupertinoColors.systemGreen, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: CupertinoColors.systemBlue, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: CupertinoColors.destructiveRed, width: 1.w),
      ),
      helperStyle: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 16.sp,
        color: AppColors.mainTextColor,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 16.sp,
        color: AppColors.todoLightTextSecondary,
        fontWeight: FontWeight.w500,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 16.sp,
        color: AppColors.todoLightTextSecondary,
        fontWeight: FontWeight.w500,
      ),
      errorStyle: TextStyle(
        fontFamily: 'Manrope',
        height: 1.3,
        fontSize: 16.sp,
        overflow: TextOverflow.visible,
        color: CupertinoColors.destructiveRed,
        fontWeight: FontWeight.w500,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        enableFeedback: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.btnBorderRadius.r),
        ),
        backgroundColor: AppColors.mainButtonBg,
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateColor.transparent,
        surfaceTintColor: Colors.transparent,
        fixedSize: Size(double.infinity / 2 - 30, AppSizes.btnHeight.h),
        textStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: AppSizes.listFS.sp,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
