import 'package:flutter/material.dart';

class CustomAuthTextFormField extends StatelessWidget {
  final String hintText;
  final String? Function(String?) validator;
  final TextEditingController textEditingController;
  const CustomAuthTextFormField({Key? key, required this.hintText, required this.textEditingController, required this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 20
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black,width: 1)
          )
        ),
      ),
    );
  }
}
