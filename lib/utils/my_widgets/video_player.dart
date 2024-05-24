import 'package:flutter/Material.dart';
import 'package:video_player/video_player.dart';

import '../my_utils/constants.dart';

class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(Constants.APP_INFO!.how_to_take_offer_video??"",
    )..initialize().then((_) {
      _controller.play();
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}