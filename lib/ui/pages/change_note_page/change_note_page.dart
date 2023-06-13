import 'package:flutter/material.dart';
import 'package:note_app/domain/provider/note_provider.dart';
import 'package:note_app/ui/pages/add_note_page/add_note_page.dart';
import 'package:note_app/ui/theme/up_text_styles.dart';
import 'package:note_app/ui/widgets/app_bar_shadow/app_bar_shadow.dart';
import 'package:provider/provider.dart';

class ChangeNotePage extends StatelessWidget {
  const ChangeNotePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NoteProvider>(context);
    final getindex = ModalRoute.of(context)?.settings.arguments;
    int index = getindex is int ? getindex : 0;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        flexibleSpace: const AppBarShadow(),
        title: const Text('Изменить заметку', style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ValueInput(
            inputText: 'Заголовок',
            controller: model.titleController,
          ),
          const SizedBox(
            height: 16,
          ),
          ValueInput(
            inputText: 'Заметка',
            controller: model.noteController,
          ),
          const SizedBox(
            height: 16,
          ),
          ControlBtn(
            btnAction: () {
              model.changeNoteData(
                index: index,
                context: context,
              );
              Navigator.of(context).pop();
            },
            btnText: 'Изменить',
          ),
        ],
      ),
    );
  }
}
