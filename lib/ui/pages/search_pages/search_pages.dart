import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/domain/hive/hive_boxes.dart';
import 'package:note_app/domain/hive/note_data.dart';
import 'package:note_app/ui/theme/app_colors.dart';
import 'package:note_app/ui/theme/up_text_styles.dart';
import 'package:note_app/ui/widgets/app_bar_shadow/app_bar_shadow.dart';
import 'package:note_app/ui/widgets/list_item/list_Item.dart';

class SearchPages extends StatefulWidget {
  const SearchPages({super.key});

  @override
  State<SearchPages> createState() => _SearchPagesState();
}

class _SearchPagesState extends State<SearchPages> {
  // список всех заметок
  final _notes = HiveBoxes.notes.values.toList();

  // филтрованный список заметок
  var filteredList = <NoteData>[];
  // контроллер для получения данных с текст поля
  final TextEditingController searchEditingContriller = TextEditingController();

  void _serchNote() {
    final quary = searchEditingContriller.text;

    if (quary.isNotEmpty) {
      filteredList = _notes.where((note) {
        return note.title.toLowerCase().contains(quary.toLowerCase()) ||
            note.note.toLowerCase().contains(quary.toLowerCase());
      }).toList();
    } else {
      filteredList = _notes;
    }
    setState(() {});
  }

  @override
  void initState() {
    filteredList = _notes;
    searchEditingContriller.addListener(_serchNote);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarShadow(),
        title: TextField(
          controller: searchEditingContriller,
          style: const TextStyle(
            fontSize: 22,
            height: 28 / 22,
            color: AppColors.primaryTextColor,
          ),
          cursorColor: AppColors.primaryTextColor,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            hintText: 'Поиск...',
            hintStyle: TextStyle(
              fontSize: 22,
              height: 28 / 22,
              color: AppColors.primaryTextColor,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: AppColors.secondaryTextColor,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (searchEditingContriller.text.isNotEmpty) {
                searchEditingContriller.clear();
              }
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<NoteData>>(
        valueListenable: HiveBoxes.notes.listenable(),
        builder: (context, value, child) {
          return filteredList.isNotEmpty
              ? ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => ListItem(
                    title: filteredList[index].title,
                    note: filteredList[index].note,
                    date: filteredList[index].date,
                    index: index,
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: filteredList.length,
                )
              : const Center(
                  child: Text(
                    'Нет заметок',
                    style: AppTextStyles.appBarTitle,
                  ),
                );
        },
      ),
    );
  }
}
