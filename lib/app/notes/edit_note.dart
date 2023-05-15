import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app_php/app/home/home.dart';
import 'package:notes_app_php/components/crud.dart';
import 'package:notes_app_php/components/text_form_field.dart';
import 'package:notes_app_php/components/valid.dart';
import 'package:notes_app_php/constants/linkapi.dart';

class EditNotes extends StatefulWidget {
  final notes;
  static const String routeName = 'edit-note';

  const EditNotes({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> with Crud {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  File? myFile;

  editNotes() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var response;
      if (myFile == null) {
        response = await postRequest(linkEditNote, {
          "title": titleController.text,
          "content": contentController.text,
          "id": widget.notes["notes_id"].toString(),
          "imagename": widget.notes["notes_image"].toString(),
        });
      } else {
        response = await postRequestToUploadFiles(
            linkEditNote,
            {
              "title"    : titleController.text,
              "content"  : contentController.text,
              "id"       : widget.notes["notes_id"].toString(),
              "imagename": widget.notes["notes_image"].toString(),
            },
            myFile!);
      }

      setState(() {
        isLoading = false;
      });
      if (response["status"] == "success") {
        if (!mounted) return;
        Navigator.of(context).pushReplacementNamed(HomeView.routeName);
      } else {}
    }
  }

  @override
  void initState() {
    titleController.text = widget.notes["notes_title"];
    contentController.text = widget.notes["notes_content"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Edit Notes"),
          centerTitle: true,
        ),
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  CustomAuthTextFormField(
                    hintText: "Title",
                    textEditingController: titleController,
                    validator: (val) {
                      return validInput(val: val!, min: 1, max: 40);
                    },
                  ),
                  CustomAuthTextFormField(
                    hintText: "Content",
                    textEditingController: contentController,
                    validator: (val) {
                      return validInput(val: val!, min: 10, max: 255);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: MaterialButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () async {
                            await editNotes();
                          },
                          child: const Text(
                            "Edit Note",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: MaterialButton(
                          color: myFile == null ? Colors.black38 : Colors.green,
                          onPressed: () async {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 100,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Choose your image...",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        Navigator.of(context).pop();
                                        myFile = File(xFile!.path);
                                        setState(() {});
                                      },
                                      child: Card(
                                        shadowColor: Colors.grey,
                                        elevation: 6,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          color: Colors.white,
                                          child: const Icon(
                                            Icons.image,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        XFile? xFile = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera);
                                        Navigator.of(context).pop();
                                        myFile = File(xFile!.path);
                                        setState(() {});
                                      },
                                      child: Card(
                                        shadowColor: Colors.grey,
                                        elevation: 6,
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          color: Colors.white,
                                          child: const Icon(
                                            Icons.camera_alt,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
