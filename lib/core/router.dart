import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:serious_game/Features/congratulation/congratulation.dart';
import 'package:serious_game/Features/home/home_screen.dart';
import 'package:serious_game/Features/landing/landing_page.dart';
import 'package:serious_game/Features/questions/welcome_page.dart';
import 'package:serious_game/core/service/auth_service.dart';

final LoginController loginController = Get.find<LoginController>();
final _storage = GetStorage();

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  redirect: (context, state) {
    final loggedIn = loginController.isLoggedIn;

    if (loggedIn && state.uri.path == '/home') {
      return '/landing';
    }

    if (!loggedIn && state.uri.path == '/landing') {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: '/landing',
      name: 'landing',
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(
      path: '/congrat',
      name: 'congrat',
      builder: (context, state) => CongratulationScreen(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: Text('Erreur')),
    body: Center(child: Text('Page introuvable')),
  ),
);
