import 'package:flutter/cupertino.dart';
import 'package:note_app/ui/theme/app_colors.dart';

abstract class AppTextStyles {
  static const TextStyle appBarTitle = TextStyle(
    fontSize: 22,
    color: AppColors.primaryTextColor,
    height: 28 / 22,
    
  );
  static const TextStyle titleText = TextStyle(
    fontSize: 16,
    color: AppColors.primaryTextColor,
    height: 18.75 / 22,
    
  );
  
}
