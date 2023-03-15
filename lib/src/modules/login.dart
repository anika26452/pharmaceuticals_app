import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:gentry_pharmaceuticals_app/src/controller/auth_controller.dart';
import 'package:get/get.dart';

import '../utils/app_images.dart';
import '../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());

 // bool _validateid = false, _validatepass = false, _passwordVisible = false;

  Map user = {"userid": "", "password": ""};


  void initState() {
    super.initState();
    controller.passwordVisible.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: AppColor.appcolor,
      ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Get.width / 12),
            child: Column(children: [
              SizedBox(height: 50,),
              Container(
                width: Get.width / 2,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(Get.width / 2)),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Get.width / 2)),
                    child: Image.asset(AppImages.logo)),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: controller.valueuserid,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appcolor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Enter Username/UserID',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorText:
                        controller.validateid.value ? "Please enter your user id" : null),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                return TextField(
                  controller: controller.valuepasswordid,
                  obscureText: !controller.passwordVisible.value,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor.appcolor,
                            width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.key),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      errorText:
                      controller.validatepass.value ? "Please enter your passsword" : null,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColor.appcolor,
                        ),
                        onPressed: () {
                          controller.passwordVisible.value = !controller.passwordVisible.value;
                        },
                      )),
                );
              }),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                    radius: 20,
                    //backgroundColor: Color(0xff4c505b),
                    backgroundColor: Colors.grey[800],
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () async {
                        var connection = await Connectivity().checkConnectivity();
                        setState(()  {
                          controller.valueuserid.text == "" ||
                                  controller.valueuserid.text.isEmpty
                              ? controller.validateid.value = true
                              : controller.validateid.value = false;
                          controller.valuepasswordid.text == "" ||
                                  controller.valuepasswordid.text.isEmpty
                              ? controller.validatepass.value = true
                              : controller.validatepass.value = false;
                          if (!controller.validatepass.value && !controller.validateid.value) {
                            var userid = controller.valueuserid.text;
                            var userpass = controller.valuepasswordid.text;

                            user['userid'] = userid;
                            user['password'] = userpass;

                            if(connection == ConnectivityResult.none) {
                              Get.snackbar("Connection Error", "Your phone is not connected with internet",
                                snackPosition: SnackPosition.TOP, backgroundColor: Colors.white, colorText: Colors.red[900], icon: Icon(Icons.wifi_off, color: Colors.red[900],));
                            }else {
                              controller.getuser(user);
                            }
                          }
                        });
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  )
                ],
              )
            ]),
          ),
        ));
  }
}


