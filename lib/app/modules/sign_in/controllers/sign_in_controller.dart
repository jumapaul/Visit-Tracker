import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visit_tracker/app/routes/app_pages.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final supabase = Supabase.instance.client;
  var isLoading = false.obs;

  signIn() async {
    try {
      isLoading.value = true;
      AuthResponse response = await supabase.auth.signInWithPassword(
        password: passwordController.text,
        email: emailController.text,
      );

      if (response.user != null) {
        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
      }

      isLoading.value = false;
    } catch (error) {
      if (error is AuthApiException) {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(SnackBar(content: Text(error.message)));
        isLoading.value = false;
      } else {
        ScaffoldMessenger.of(
          Get.context!,
        ).showSnackBar(SnackBar(content: Text("An error occurred")));
        isLoading.value = false;
      }
    }
  }

  resetPassword() async {
    try {
      await supabase.auth.resetPasswordForEmail(emailController.text);
    } catch (error) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
