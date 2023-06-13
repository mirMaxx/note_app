import 'package:flutter/material.dart';
import 'package:note_app/domain/provider/note_provider.dart';
import 'package:note_app/ui/theme/app_colors.dart';
import 'package:note_app/ui/theme/up_text_styles.dart';
import 'package:note_app/ui/widgets/app_bar_shadow/app_bar_shadow.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        flexibleSpace: const AppBarShadow(),
        title: const Text('Добавить заметку', style: AppTextStyles.appBarTitle),
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
            btnAction:() => model.addNote(context),
            btnText: 'Добавить',
          ),
        ],
      ),
    );
  }
}

class ValueInput extends StatelessWidget {
  final String inputText;
  final TextEditingController controller;
  const ValueInput({
    super.key,
    this.inputText = '',
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: const Color.fromARGB(0, 145, 145, 151),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff79747E),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff79747E),
          ),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        hintText: inputText,
        hintStyle: const TextStyle(
            fontSize: 16, height: 24 / 16, color: AppColors.primaryTextColor),
        labelText: inputText,
        labelStyle: const TextStyle(
          fontSize: 12,
          height: 16 / 12,
          color: AppColors.secondaryTextColor,
          backgroundColor: AppColors.bgcolor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

class ControlBtn extends StatelessWidget {
  final String btnText;
  final Function btnAction;
  const ControlBtn({super.key, this.btnText = '', required this.btnAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FloatingActionButton.extended(
        backgroundColor: AppColors.bgcolor,
        onPressed: () => btnAction(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        elevation: 2,
        highlightElevation: 4,
        label: Text(
          btnText,
          style: const TextStyle(
            color: AppColors.btnTextColor,
            fontSize: 14,
            height: 20 / 14,
          ),
        ),
      ),
    );
  }
}
