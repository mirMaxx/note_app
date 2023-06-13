import 'package:flutter/cupertino.dart';
import 'package:note_app/ui/pages/add_note_page/add_note_page.dart';
import 'package:note_app/ui/pages/change_note_page/change_note_page.dart';
import 'package:note_app/ui/pages/home_page/home_page.dart';
import 'package:note_app/ui/pages/search_pages/search_pages.dart';
import 'package:note_app/ui/router/app_routs.dart';

abstract class AppNavigator {
  static String get initialRoute => AppRoutes.homePage;
  static Map<String, WidgetBuilder> get routes => {
    AppRoutes.homePage: (context)=> const HomePage(),
    AppRoutes.addPage:(context) => const AddNotePage(),
    AppRoutes.searhPage:(context) => const SearchPages(),
    AppRoutes.changePage:(context) => const ChangeNotePage(),
  };
}
