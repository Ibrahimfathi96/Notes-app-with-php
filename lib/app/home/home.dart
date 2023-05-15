import 'package:flutter/material.dart';
import 'package:notes_app_php/app/auth/login.dart';
import 'package:notes_app_php/app/models/note.dart';
import 'package:notes_app_php/app/notes/add_note.dart';
import 'package:notes_app_php/app/notes/edit_note.dart';
import 'package:notes_app_php/components/crud.dart';
import 'package:notes_app_php/components/custom_card.dart';
import 'package:notes_app_php/constants/linkapi.dart';
import 'package:notes_app_php/main.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'home';

  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with Crud {
  getNotes() async {
    var userId = prefs.getString("id");
    debugPrint("user id: $userId");
    var response = await postRequest(linkViewNote, {"id": userId});
    debugPrint("response: $response");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              prefs.clear();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
            },
            icon: const Icon(
              Icons.exit_to_app,
              size: 30,
            ),
          ),
        ],
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddNotes.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  debugPrint("data: ${snapshot.data}");
                  if (snapshot.data['status'] == "failed") {
                    return Column(
                      children: [
                        const Text(
                          "حاليا لا يوجد ملاحظات قم بإدخال بعض الملاحظات او قم بالتأكد بالمحاولة مرة اخري لتحميل الملاحظات.",
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                getNotes();
                              });
                            },
                            child: const Text(
                              "try again",
                              style: TextStyle(fontSize: 16),
                            )),
                      ],
                    );
                  }
                  debugPrint("data From snapshot: ${snapshot.data['data']}");
                  return ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NoteCard(
                        onDelete: () async {
                          var response = await postRequest(linkDeleteNote, {
                            "id": snapshot.data['data'][index]['notes_id']
                                .toString(),
                            "imagename" : snapshot.data['data'][index]['notes_image']
                                .toString()
                          });
                          if (response['status'] == 'success') {
                            if (!mounted) return;
                            Navigator.of(context)
                                .pushReplacementNamed(HomeView.routeName);
                          }
                        },
                        noteMD: NoteMD.fromJson(snapshot.data['data'][index]),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditNotes(
                                notes: snapshot.data['data'][index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "loading",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    const Text(
                      "حاليا لا يوجد ملاحظات قم بإدخال بعض الملاحظات او قم بالتأكد بالمحاولة مرة اخري لتحميل الملاحظات.",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            getNotes();
                          });
                        },
                        child: const Text(
                          "try again",
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
