import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notes_app_php/app/auth/success.dart';
import 'package:notes_app_php/components/crud.dart';
import 'package:notes_app_php/components/text_form_field.dart';
import 'package:notes_app_php/components/valid.dart';
import 'package:notes_app_php/constants/linkapi.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "sign-up";

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  signUp() async {
    setState(() {
      isLoading = true;
    });
    var response = await Crud().postRequest(linkSignUp, {
      "username": userNameController.text,
      "email": emailController.text,
      "password": passwordController.text
    });
    setState(() {
      isLoading = false;
    });
    if (response["status"] == "success") {
      if (!mounted) return;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(SuccessPage.routeName, (route) => false);
    } else {
      debugPrint("sign up failed");
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
                        hintText: "User Name",
                        textEditingController: userNameController,
                        validator: (val) {
                          return validInput(val: val!, min: 3, max: 25);
                        },
                      ),
                      CustomAuthTextFormField(
                        hintText: "Email",
                        textEditingController: emailController,
                        validator: (val) {
                          return validInput(val: val!, min: 10, max: 50);
                        },
                      ),
                      CustomAuthTextFormField(
                        hintText: "Password",
                        textEditingController: passwordController,
                        validator: (val) {
                          return validInput(val: val!, min: 10, max: 25);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await signUp();
                          }
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        child: const Text(
                          "Sign up",
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
                            "Already have an account?",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
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
