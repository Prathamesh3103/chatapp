// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:chatapp/colors.dart';
import 'package:chatapp/common/enum/message_enum.dart';
import 'package:chatapp/common/provider/message_reply_provider.dart';
import 'package:chatapp/common/utils/util.dart';
import 'package:chatapp/features/chat/controller/chat_controller.dart';
import 'package:chatapp/features/chat/widgets/message_reply_preview.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();

  void sendTextMessage() async {
    if (isShowSendButton == true) {
      ref.read(ChatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
            widget.isGroupChat,
          );

      setState(() {
        _messageController.text = '';
      });
    }
  }

  void sendFileMessage(
    File file,
    MessageEnum messageEnum,
  ) {
    ref.read(ChatControllerProvider).sendFileMessage(
          context,
          file,
          widget.recieverUserId,
          messageEnum,
          widget.isGroupChat,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void selectGIF() async {
    final gif = await pickGIF(context);
    if (gif != null) {
      // ignore: use_build_context_synchronously
      ref.read(ChatControllerProvider).sendGIFMessage(
            context,
            gif.url,
            widget.recieverUserId,
            widget.isGroupChat,
          );
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messageReply = ref.watch(messageReplyProvider);
    final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: mobileChatBoxColor,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: toggleEmojiKeyboardContainer,
                              icon: Icon(
                                Icons.emoji_emotions,
                                color: Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: selectGIF,
                              icon: Icon(
                                Icons.gif,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    suffixIcon: SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: selectImage,
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: selectVideo,
                            icon: Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                right: 2,
                left: 2,
              ),
              child: CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: GestureDetector(
                  // ignore: sort_child_properties_last
                  child: Icon(
                    isShowSendButton ? Icons.send : Icons.mic,
                    color: Colors.white,
                  ),
                  onTap: sendTextMessage,
                ),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: EmojiPicker(onEmojiSelected: (category, emoji) {
                  setState(() {
                    _messageController.text =
                        _messageController.text + emoji.emoji;
                  });

                  if (!isShowSendButton) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  }
                }),
              )
            : const SizedBox(),
      ],
    );
  }
}
