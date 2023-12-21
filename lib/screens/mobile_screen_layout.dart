// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chatapp/colors.dart';
import 'package:chatapp/common/utils/util.dart';
import 'package:chatapp/features/auth/controller/auth_controller.dart';
import 'package:chatapp/features/contacts_list/screens/contact_list_screen.dart';
import 'package:chatapp/features/chat/widgets/contacts_list.dart';
import 'package:chatapp/features/group/screens/create_group_screen.dart';
import 'package:chatapp/features/status/screens/confirm_status_screen.dart';
import 'package:chatapp/features/status/screens/status_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(AuthControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(AuthControllerProvider).setUserState(false);
        break;
      case AppLifecycleState.hidden:
        ref.read(AuthControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text(
            'Chillzone',
            style: TextStyle(
                color: Color.fromARGB(255, 106, 106, 106),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.grey,
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text(
                    'Create Group',
                  ),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                      context,
                      CreateGroupScreen.routename,
                    ),
                  ),
                ),
              ],
            )
          ],
          bottom: TabBar(
              controller: tabBarController,
              indicatorColor: tabColor,
              indicatorWeight: 4,
              labelColor: tabColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              tabs: const [
                Tab(
                  text: 'CHATS',
                ),
                Tab(
                  text: 'STATUS',
                ),
                Tab(
                  text: 'CALLS',
                ),
              ]),
        ),
        body: TabBarView(controller: tabBarController, children: const [
          ContactsList(),
          StatusContactsScreen(),
          Text('Calls')
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (tabBarController.index == 0) {
              Navigator.pushNamed(
                context,
                SelectContactsScreen.routeName,
              );
            } else {
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                Navigator.pushNamed(context, ConfirmStatusScreen.routeName,
                    arguments: pickedImage);
              }
            }
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
