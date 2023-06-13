import 'package:flutter/cupertino.dart';
import 'package:note_app/domain/hive/hive_boxes.dart';
import 'package:note_app/domain/hive/note_data.dart';

class NoteProvider extends ChangeNotifier {
  // Контроллеры нужны ддя получения данных из текстовых полей
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  void addNote(BuildContext context) async {
    await HiveBoxes.notes
        .add(
          NoteData(
            title: titleController.text.isNotEmpty
                ? titleController.text
                : 'Нет заголовка',
            note: noteController.text.isNotEmpty
                ? noteController.text
                : 'Нет заметки',
          ),
        )
        .then((value) => Navigator.of(context).pop());

    clearControllers();
    notifyListeners();
  }

  void deleteNote({required int index, required BuildContext context}) async {
    await HiveBoxes.notes
        .deleteAt(index)
        .then((value) => Navigator.of(context).pop());
    notifyListeners();
  }

  void clearControllers() {
    titleController.clear();
    noteController.clear();
  }

  void setControllers({required int index}) {
    titleController.text = HiveBoxes.notes.getAt(index)?.title ?? '';
    noteController.text = HiveBoxes.notes.getAt(index)?.note ?? '';
  }

  void changeNoteData({
    required int index,
    required BuildContext context,
  }) {
    HiveBoxes.notes.putAt(
      index,
      NoteData(
        title: titleController.text.isNotEmpty
            ? titleController.text
            : 'Нет заголовка',
        note: noteController.text.isNotEmpty
            ? noteController.text
            : 'Нет заметки',
      ),
    );
  }
}
