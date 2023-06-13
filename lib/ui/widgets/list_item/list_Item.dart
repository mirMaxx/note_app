import 'package:flutter/material.dart';
import 'package:note_app/domain/provider/note_provider.dart';
import 'package:note_app/ui/router/app_routs.dart';
import 'package:note_app/ui/theme/app_colors.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String note;
  final String date;
  final int index;

  const ListItem({
    super.key,
    this.title = '',
    this.note = '',
    this.date = '',
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NoteProvider>(context);
    return GestureDetector(
      onTap: () {
        model.setControllers(index: index);
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) => BottomModelDialog(
            index: index,
            title: title,
            note: note,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(
          minHeight: 117,
        ),
        decoration: const BoxDecoration(
          color: AppColors.bgcolor,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, .1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: ItemContent(title: title, date: date, note: note),
      ),
    );
  }
}

class ItemContent extends StatelessWidget {
  const ItemContent({
    Key? key,
    required this.title,
    required this.date,
    required this.note,
  }) : super(key: key);

  final String title;
  final String date;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            height: 19 / 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: Color(0xffCAC4D0),
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        Text(
          note,
          style: const TextStyle(
            fontSize: 14,
            height: 16 / 14,
            color: AppColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}

class BottomModelDialog extends StatelessWidget {
  final String title;
  final String note;
  final int index;
  const BottomModelDialog({
    Key? key,
    required this.title,
    required this.note,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 179,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: ListItemContent(
        index: index,
        title: title,
        note: note,
      ),
    );
  }
}

class ListItemContent extends StatelessWidget {
  final String title;
  final String note;
  final int index;
  const ListItemContent({
    Key? key,
    required this.title,
    required this.note,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<NoteProvider>(context);

    return Column(
      children: [
        Container(
          width: 34,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xffDEDEDE),
            borderRadius: BorderRadius.circular(19),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          maxLines: 1,
          style: const TextStyle(
            fontSize: 16,
            height: 19 / 16,
            color: AppColors.primaryTextColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          note,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            height: 16 / 14,
            color: AppColors.secondaryTextColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Spacer(),
        BottomMenuBtn(
          icon: Icons.edit,
          textBtn: 'Редактировать',
          ontapBtn: () {
            Navigator.of(context).pushNamed(AppRoutes.changePage, arguments: index,);
          },
        ),
        BottomMenuBtn(
          icon: Icons.backspace,
          textBtn: 'Удалить',
          ontapBtn: () {
            showDialog(
              context: context,
              builder: (context) => DeleteModalDialog(
                title: title,
                model: model,
                index: index,
              ),
            );
          },
        ),
      ],
    );
  }
}

class DeleteModalDialog extends StatelessWidget {
  const DeleteModalDialog({
    Key? key,
    required this.title,
    required this.model,
    required this.index,
  }) : super(key: key);

  final String title;
  final NoteProvider model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Удалить',
        style: TextStyle(
          fontSize: 24,
          height: 32 / 24,
          color: AppColors.primaryTextColor,
        ),
      ),
      content: Text(
        'Удалить заметку $title',
        maxLines: 1,
        style: const TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: AppColors.secondaryTextColor,
        ),
      ),
      actions: [
        DeleteDialogBtn(
          text: 'Отмена',
          btnAction: () {
            Navigator.of(context).pop();
          },
        ),
        DeleteDialogBtn(
          text: 'Удалить',
          btnAction: () {
            model.deleteNote(index: index, context: context);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class BottomMenuBtn extends StatelessWidget {
  final IconData icon;
  final String textBtn;
  final Function ontapBtn;
  const BottomMenuBtn({
    super.key,
    required this.icon,
    required this.textBtn,
    required this.ontapBtn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: () => ontapBtn(),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 19,
            ),
            Text(
              textBtn,
              style: const TextStyle(
                color: Color(0xff1C1B1F),
                fontSize: 16,
                height: 24 / 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteDialogBtn extends StatelessWidget {
  final String text;
  final Function btnAction;
  const DeleteDialogBtn({super.key, this.text = '', required this.btnAction});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => btnAction(),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: AppColors.btnTextColor,
        ),
      ),
    );
  }
}
