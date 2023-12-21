import 'dart:io';

import 'package:chatapp/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:chatapp/features/auth/repository/auth_repo.dart';

// ignore: non_constant_identifier_names
final AuthControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authrepo: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(AuthControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepo authrepo;
  final ProviderRef ref;
  AuthController({
    required this.authrepo,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authrepo.getCurrentUserData();

    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authrepo.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String verificationId, String userOTP) {
    authrepo.verifyOTP(
      verificationId: verificationId,
      userOTP: userOTP,
      context: context,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authrepo.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataById(String userId) {
    return authrepo.userData(userId);
  }

  void setUserState(bool isOnline) {
    authrepo.setUserState(isOnline);
  }
}
