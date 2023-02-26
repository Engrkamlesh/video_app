// ignore_for_file: camel_case_types

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class chewie_video_Play extends StatefulWidget {
  final String url;
  const chewie_video_Play({super.key, required this.url});

  @override
  State<chewie_video_Play> createState() => _chewie_video_PlayState();
}

class _chewie_video_PlayState extends State<chewie_video_Play> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

@override
  void initState(){
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16/9,
      looping: true,
      );
  }

void _videoIni()async{
    _videoPlayerController.initialize();
}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
        child: Chewie(controller: _chewieController),
        )
      ],
    );
  }
}