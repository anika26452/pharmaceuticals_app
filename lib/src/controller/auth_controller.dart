import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController{

  RxBool validateid =false.obs;
  RxBool validatepass =false.obs;
  RxBool passwordVisible =false.obs;

  final valueuserid = TextEditingController();
  final valuepasswordid = TextEditingController();
  var message, ad_user_id, userid,employeename, pass, orgname,orgid,address,  designation, c_bpartner_id;

  static const apiBaseUrl = 'http://172.16.9.186:9000/';

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<void> getuser(Map userdata) async{

    showLoaderDialog(Get.context!);
    var userid = userdata['userid'];
    var pasword = userdata['password'];

    var url = Uri.parse(apiBaseUrl + 'users/'+userid+"/"+pasword);

    Map<String,String> headers = {
      'Content-type' : 'application/json',
      'Accept': 'application/json',
    };

    try {

      final response = await http.get(url, headers: headers);
      print(response);

      if (response.statusCode == 200) {
        print(response.body);

        Map<String, dynamic> responseJson = json.decode(response.body);
        print(responseJson);

        message = responseJson['message'];

        if(message == "Got the user"){
          ad_user_id = responseJson['userdata'][0]['ad_user_id'];
          userid = responseJson['userdata'][0]['userid'];
          employeename = responseJson['userdata'][0]['employeename'];
          orgname = responseJson['userdata'][0]['orgname'];
          orgid = responseJson['userdata'][0]['org_id'];
          address = responseJson['userdata'][0]['address1'];
          pass = responseJson['userdata'][0]['password'];
          c_bpartner_id = responseJson['userdata'][0]['c_bpartner_id'];

          print(message);
          Navigator.pop(Get.context!);
          //Get.to(() => Navigat());

        }else{
          Navigator.pop(Get.context!);
          Get.defaultDialog(
              title: "Error",
              middleText: "Employee ID/Password doesn't match!"
          );
        }
      }else{
        Navigator.pop(Get.context!);
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Navigator.pop(Get.context!);
      Get.defaultDialog(
        title: "Error",
        middleText: "Server is off"
      );
      print(error);
    }
  }
}