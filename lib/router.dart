import 'dart:io';

import 'package:chatapp/common/widgets/error.dart';
import 'package:chatapp/features/auth/screens/login_screen.dart';
import 'package:chatapp/features/auth/screens/otp_screen.dart';
import 'package:chatapp/features/auth/screens/user_info_screen.dart';
import 'package:chatapp/features/contacts_list/screens/contact_list_screen.dart';
import 'package:chatapp/features/chat/screens/mobile_chat_screen.dart';
import 'package:chatapp/features/group/screens/create_group_screen.dart';
import 'package:chatapp/features/status/screens/confirm_status_screen.dart';
import 'package:chatapp/features/status/screens/status_screen.dart';
import 'package:chatapp/models/status_model.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInfoScreen(),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
          isGroupChat: isGroupChat,
          profilePic: profilePic,
        ),
      );

    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );

    case StatusScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
        builder: (context) => StatusScreen(
          status: status,
        ),
      );

    case CreateGroupScreen.routename:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );

    default:
      return MaterialPageRoute(
          builder: ((context) => const Scaffold(
                body: ErrorScreen(error: 'This Page doesn\'t exist'),
              )));
  }
}
