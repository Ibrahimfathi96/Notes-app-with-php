import 'package:flutter/material.dart';
import 'package:notes_app_php/app/auth/login.dart';
import 'package:notes_app_php/app/home/home.dart';

class SuccessPage extends StatefulWidget {
  static const String routeName = 'success';

  const SuccessPage({Key? key}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Colors.blue,
            child: Icon(Icons.done,weight: 10,size: 80,color: Colors.white,),
            // child: Image.asset("assets/Path4080.png",color: Colors.white,),
          ),
          const SizedBox(height: 10,),
          const Center(
            child: Text(
              "تم إنشاء الحساب بنجاح",
              style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Text("الان يمكنك تسجيل الدخول",
              style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),
            ),
          ),
          MaterialButton(
            padding:const EdgeInsets.symmetric(horizontal: 60,),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(Login.routeName, (route) => false);
            },
            child: const Text("تسجيل الدخول",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}
