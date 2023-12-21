// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:enough_giphy_flutter/enough_giphy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar({required BuildContext context, required String content}) {
  // Find the nearest Scaffold in the widget tree
  final scaffold = ScaffoldMessenger.of(context);

  if (scaffold is Scaffold) {
    // If Scaffold is found, show SnackBar
    scaffold.showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  } else {
    // If Scaffold is not found, you can use a fallback like showDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      video = File(pickedVideo.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return video;
}

Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await Giphy.getGif(
      context: context,
      apiKey: 'Ci8Gq846L65NDENrFgvWH1si0TL1n6hz',
    );
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return gif;
}
