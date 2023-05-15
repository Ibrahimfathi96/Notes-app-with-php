import 'package:notes_app_php/constants/messages.dart';

validInput({required String val, required int min,required int max}) {
  if(val.isEmpty){
    return "$validationMessage.";
  }
  if(val.length > max){
    return "$validationMessageMax $max";
  }
  if(val.length < min){
    return "$validationMessageMax $min";
  }
}
