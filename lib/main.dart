import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app/domain/hive/hive_keys.dart';
import 'package:note_app/domain/hive/note_data.dart';
import 'package:note_app/ui/app.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteDataAdapter());
  await Hive.openBox<NoteData>(HiveKeys.boxNotesKey);
  runApp(const NoteApp());
}
