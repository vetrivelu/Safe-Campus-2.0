import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safecampus/controllers.dart/auth_controller.dart';
import 'package:safecampus/controllers.dart/user_controller.dart';
import 'package:safecampus/screens/auth/login.dart';
import 'package:safecampus/screens/auth/verify_email.dart';
import 'package:safecampus/screens/home.dart';
import 'package:safecampus/screens/profile_form.dart';

class AuthRouter extends StatelessWidget {
  const AuthRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          User user = snapshot.data!;
          Get.put(UserController());
          if (user.emailVerified) {
            return GetBuilder<UserController>(
                init: userController,
                builder: (context) {
                  if (userController.user == null) {
                    return ProfileForm();
                  } else {
                    return const Home();
                  }
                });
          } else {
            return const VerifyEmail();
          }
        } else {
          return const Login();
        }
      },
    );
  }
}
