import 'package:hive/hive.dart';
import 'package:note_app/domain/hive/hive_keys.dart';
import 'package:note_app/domain/hive/note_data.dart';

class HiveBoxes {
  static final Box<NoteData> notes = Hive.box<NoteData>(HiveKeys.boxNotesKey);
  
}
