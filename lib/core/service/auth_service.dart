import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:serious_game/core/apis/api.dart';

class LoginController extends GetxController {
  LoginController();

  RxBool showSignup = true.obs;

  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var ageController = TextEditingController();
  var passwordController = TextEditingController();
  late SingleValueDropDownController cnt;

  // Error states
  var usernameError = ''.obs;
  var passwordError = ''.obs;
  var emailError = ''.obs;
  var ageError = ''.obs;
  var sexError = ''.obs;
  var errorLoginMessage = ''.obs;
  var errorMessage = ''.obs;
  var isSigned = false.obs;

  var isLoading = false.obs;

  // Storage & token
  final _storage = GetStorage();
  var token = ''.obs;
  var userId = ''.obs;

  bool get isLoggedIn => token.isNotEmpty;
  bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = jsonDecode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'];

      if (exp == null) return true;

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    cnt = SingleValueDropDownController();

    // Load token from local storage if exists
    token.value = _storage.read('token') ?? '';
    userId.value = _storage.read('userId') ?? '';
    if (isLoggedIn) {
      isSigned.value = true;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    ageController.dispose();
    cnt.dispose();
    super.onClose();
  }

  // Clear error messages
  void clearErrors() {
    usernameError.value = '';
    passwordError.value = '';
    emailError.value = '';
    ageError.value = '';
    sexError.value = '';
    errorLoginMessage.value = '';
    errorMessage.value = '';
  }

  // Save token & userId persistently
  void saveSession(String newToken, String newUserId) {
    token.value = newToken;
    userId.value = newUserId;
    _storage.write('token', newToken);
    _storage.write('userId', newUserId);
    isSigned.value = true;
  }

  // Remove token & userId on logout
  void logout() {
    token.value = '';
    userId.value = '';
    isSigned.value = false;
    _storage.remove('token');
    _storage.remove('userId');
  }

  // Signup
  Future<void> signup() async {
    clearErrors();
    isLoading.value = true;

    // Validation des champs
    if (usernameController.text.isEmpty)
      usernameError.value = "Le nom complet est requis";
    if (emailController.text.isEmpty)
      emailError.value = "L'adresse e-mail est requise";
    if (passwordController.text.isEmpty)
      passwordError.value = "Le mot de passe est requis";
    if (ageController.text.isEmpty) ageError.value = "L'âge est requis";
    if (cnt.dropDownValue == null) sexError.value = "Le sexe est requis";

    if (usernameError.isNotEmpty ||
        emailError.isNotEmpty ||
        passwordError.isNotEmpty ||
        ageError.isNotEmpty ||
        sexError.isNotEmpty) {
      isLoading.value = false;
      return;
    }

    final data = {
      "fullName": usernameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "age": int.tryParse(ageController.text) ?? 0,
      "sex": cnt.dropDownValue!.value,
    };

    try {
      final res = await ApiService.signup(data);
      saveSession(res.data['token'], res.data['userId']);
    } on DioException catch (e) {
      print("Erreur Dio: ${e.message}");
      if (e.response != null) {
        final error = e.response!.data["error"];
        if (error != null &&
            (error.contains("duplicate") || error.contains("exists"))) {
          errorMessage.value = "Un compte avec cet e-mail existe déjà.";
        } else {
          errorMessage.value = error ?? "Échec de l'inscription";
        }
      } else {
        errorMessage.value =
            "Erreur réseau. Veuillez vérifier votre connexion.";
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Login
  Future<void> login() async {
    clearErrors();
    isLoading.value = true;

    if (emailController.text.isEmpty)
      emailError.value = "L'adresse e-mail est requise";
    if (passwordController.text.isEmpty)
      passwordError.value = "Le mot de passe est requis";

    if (emailError.isNotEmpty || passwordError.isNotEmpty) {
      isLoading.value = false;
      return;
    }

    try {
      final res = await ApiService.login({
        "email": emailController.text,
        "password": passwordController.text,
      });

      saveSession(res.data['token'], res.data['userId']);
    } on DioException catch (e) {
      if (e.response != null) {
        final error = e.response!.data["error"];
        if (error != null && error.contains("not found")) {
          errorLoginMessage.value = "Aucun compte trouvé avec cet e-mail.";
        } else if (error != null && error.contains("Invalid credentials")) {
          errorLoginMessage.value = "Mot de passe incorrect.";
        } else {
          errorLoginMessage.value = error ?? "Échec de la connexion.";
        }
      } else {
        errorLoginMessage.value =
            "Erreur réseau. Veuillez vérifier votre connexion.";
      }
    } finally {
      isLoading.value = false;
    }
  }
}
