import 'package:flutter/material.dart';
import 'package:notes_app_php/app/models/note.dart';
import 'package:notes_app_php/constants/linkapi.dart';

class NoteCard extends StatelessWidget {

  final NoteMD noteMD;
  final void Function()? onTap;
  final void Function()? onDelete;

  const NoteCard(
      {Key? key,
      required this.noteMD,
      required this.onTap, this.onDelete,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                "$linkImagePath/${noteMD.notesImage}",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text(noteMD.notesTitle!),
                subtitle: Text(noteMD.notesContent!),
                trailing: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete,color: Colors.red,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
