import 'package:flutter/cupertino.dart';
import 'package:note_app/ui/theme/app_colors.dart';

class AppBarShadow extends StatelessWidget {
  const AppBarShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgcolor,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
