import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather_app/routes/app_routes.dart';

class LoginController extends GetxController {
  RxBool isInitialized = false.obs;
  RxBool hidePassword = true.obs;
  RxBool isEmailValid = false.obs;
  RxBool isPassValid = false.obs;
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  @override
  void onInit() {
    isInitialized.value = true;
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void validate({required String email, required String pass}) {
    if (_emailCheck(email) && _passCheck(pass)) {
      debugPrint("Going to Home");
      emailController.clear();
      passwordController.clear();
      Get.offAllNamed(AppRoutes.home);
    }
  }

  bool _emailCheck(String email) {
    if (emailController.text.isEmpty) {
      debugPrint("Email is Empty");
      return false;
    } else {
      isEmailValid.value = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
      update();
      if (!isEmailValid.value) {
        debugPrint("Enter valid Email");
        return false;
      } else {
        return true;
      }
    }
  }

  bool _passCheck(String pass) {
    if (passwordController.text.isEmpty) {
      debugPrint("Password is Empty");
      return false;
    } else {
      isPassValid.value =
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(pass);
      update();
      if (!isPassValid.value) {
        debugPrint("Enter valid Password");
        return false;
      } else {
        return true;
      }
    }
  }
}
