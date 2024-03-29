import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/features/chat/widgets/video_player_item.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/common/enum/message_enum.dart';

class DisplayTextImgGif extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImgGif({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerItem(
                videoUrl: message,
              )
            : type == MessageEnum.gif
                ? CachedNetworkImage(
                    imageUrl: message,
                  )
                : CachedNetworkImage(
                    imageUrl: message,
                  );
  }
}
