import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:visit_tracker/app/data/model/register_user_dto.dart';

import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rxn<String?> emailErrorMessage = Rxn();
  Rxn<String?> passwordErrorMessage = Rxn();
  var isLoading = false.obs;

  final supabase = Supabase.instance.client;

  signUp() async {
    try {
      isLoading.value = true;
      bool passwordValid = isPasswordValid(passwordController.text);
      bool emailValid = validEmail(emailAddressController.text);

      RegisterUserDto user = RegisterUserDto(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
      );
      if (passwordValid && emailValid) {
        var response = await supabase.auth.signUp(
          email: emailAddressController.text,
          password: passwordController.text,
          data: user.toJson(),
        );

        if (response.user != null) {
          isLoading.value = false;
          Get.offAllNamed(Routes.SIGN_IN);
        }

        isLoading.value = false;
      }
    } catch (error) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text(error.toString())));

      isLoading.value = false;
    }
  }

  bool validEmail(String email) {
    bool isValid = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(email);

    if (email.isEmpty) {
      emailErrorMessage.value = "Email cannot be empty";
      return false;
    } else if (!isValid) {
      emailErrorMessage.value = "invalid email format";
      return false;
    }
    return true;
  }

  bool isPasswordValid(String password) {
    if (password.isEmpty) {
      passwordErrorMessage.value = "Password cannot be empty";
      return false;
    } else if (password.length < 6) {
      passwordErrorMessage.value = "Password cannot be less than 6 characters";
      return false;
    }
    return true;
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
