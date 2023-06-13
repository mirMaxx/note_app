import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_app/domain/provider/note_provider.dart';
import 'package:note_app/ui/router/app_routs.dart';
import 'package:note_app/ui/theme/app_colors.dart';
import 'package:note_app/ui/theme/up_text_styles.dart';
import 'package:note_app/ui/widgets/app_bar_shadow/app_bar_shadow.dart';
import 'package:note_app/ui/widgets/home_page_list/home_page_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const HomePageAddBtn(),
      appBar: AppBar(
        toolbarHeight: 64,
        flexibleSpace: const AppBarShadow(),
        title: const Text('Заметки', style: AppTextStyles.appBarTitle),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.searhPage);
            },
            icon: const Icon(Icons.search),
            color: AppColors.secondaryTextColor,
          ),
        ],
      ),
      body: const HomePageList(),
    );
  }
}

class HomePageAddBtn extends StatelessWidget {
  const HomePageAddBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NoteProvider>(context);
    return FloatingActionButton(
      backgroundColor: AppColors.bgcolor,
      elevation: 2,
      highlightElevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: const Icon(Icons.edit, color: AppColors.btnTextColor,),
      onPressed: () {
        model.clearControllers();
        Navigator.of(context).pushNamed(AppRoutes.addPage);
      },
    );
  }
}
