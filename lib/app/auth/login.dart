import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app_php/app/auth/sign_up.dart';
import 'package:notes_app_php/app/home/home.dart';
import 'package:notes_app_php/components/crud.dart';
import 'package:notes_app_php/components/text_form_field.dart';
import 'package:notes_app_php/components/valid.dart';
import 'package:notes_app_php/constants/linkapi.dart';
import 'package:notes_app_php/main.dart';

class Login extends StatefulWidget {
  static const String routeName = "login";

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  login() async {
    setState(() {
      isLoading = true;
    });
    var response = await Crud().postRequest(linkLogin,
        {"email": emailController.text, "password": passwordController.text});
    setState(() {
      isLoading = false;
    });
    if (response["status"] == "success") {
      prefs.setString("id", response["data"]["id"].toString());
      prefs.setString("username", response["data"]["username"]);
      prefs.setString("password", response["data"]["password"]);
      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeView.routeName, (route) => false);
    } else {
      if (!mounted) return;
      AwesomeDialog(
        context: context,
        btnCancel: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        title: "تنبيه",
        body: const Text(
          "هناك خطأ ما بالبريد الإلكتروني او الباسورد بالرجاء التحقق منهما.",
          textAlign: TextAlign.center,
        ),
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        "assets/logo.jpg",
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      CustomAuthTextFormField(
                        hintText: "Email",
                        textEditingController: emailController,
                        validator: (val) {
                          return validInput(val: val!, min: 3, max: 25);
                        },
                      ),
                      CustomAuthTextFormField(
                        hintText: "Password",
                        textEditingController: passwordController,
                        validator: (val) {
                          return validInput(val: val!, min: 3, max: 25);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await login();
                          }
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(SignUp.routeName);
                            },
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
