import 'package:flutter/material.dart';
import 'package:notes_app_php/app/auth/login.dart';
import 'package:notes_app_php/app/auth/sign_up.dart';
import 'package:notes_app_php/app/auth/success.dart';
import 'package:notes_app_php/app/home/home.dart';
import 'package:notes_app_php/app/notes/add_note.dart';
import 'package:notes_app_php/app/notes/edit_note.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences prefs ;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const NotesAppWithPHPRESTAPI());
}

class NotesAppWithPHPRESTAPI extends StatelessWidget {
  const NotesAppWithPHPRESTAPI({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:prefs.getString("id")==null? Login.routeName:HomeView.routeName,
      routes: {
        Login.routeName:(_)=> const Login(),
        SignUp.routeName:(_)=> const SignUp(),
        HomeView.routeName:(_)=> const HomeView(),
        SuccessPage.routeName:(_)=> const SuccessPage(),
        AddNotes.routeName:(_)=> const AddNotes(),
        EditNotes.routeName:(_)=> const EditNotes(),
      },
    );
  }
}

