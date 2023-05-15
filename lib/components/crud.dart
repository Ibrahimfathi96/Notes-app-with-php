import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:http/http.dart'as http;
class Crud{
  //GET Request
  getRequest(String url)async{
    try{
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        return responseBody;
      }else{
        print("status code error ${response.statusCode}");
      }
    }catch(e){
      print("Catch Error $e");
    }
  }

  //POST Request
  postRequest(String url,Map data)async{
    await Future.delayed(const Duration(seconds: 2));
    try{
      var response = await http.post(Uri.parse(url),body: data);
      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        return responseBody;
      }else{
        print("status code error ${response.statusCode}");
      }
    }catch(e){
      print("Catch Error $e");
    }
  }

  //UPLOAD Files
  postRequestToUploadFiles(String url,Map data,File file)async{
    var request = http.MultipartRequest("POST",Uri.parse(url));
    var length  = await file.length();
    var stream  = http.ByteStream(file.openRead());
    var multiPartFile = http.MultipartFile("file",stream,length,filename: basename(file.path));
    request.files.add(multiPartFile);
    data.forEach((key, value) {
      request.fields[key]=value;
    });
    var myRequest = await request.send();
    var response  = await http.Response.fromStream(myRequest);
    if(myRequest.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      debugPrint("onUploadFilesError: ${myRequest.statusCode}");
    }
  }
}