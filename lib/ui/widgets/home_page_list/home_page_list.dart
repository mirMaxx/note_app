import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/domain/hive/hive_boxes.dart';
import 'package:note_app/domain/hive/note_data.dart';
import 'package:note_app/ui/theme/up_text_styles.dart';
import 'package:note_app/ui/widgets/list_item/list_Item.dart';

class HomePageList extends StatelessWidget {
  const HomePageList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveBoxes.notes.listenable(),
      builder: (context, Box<NoteData> notes, _) {
        final notesList = notes.values.toList();
        return notesList.isNotEmpty
            ? ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => ListItem(
                  index: index,
                  title: notesList[index].title,
                  date: notesList[index].date,
                  note: notesList[index].note,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: notesList.length,
              )
            : const Center(
                child: Text(
                  'Нет заметок',
                  style: AppTextStyles.appBarTitle,
                ),
              );
      },
    );
  }
}
