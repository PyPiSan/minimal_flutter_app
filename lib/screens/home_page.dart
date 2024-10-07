import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/screens/video_controls_overlay.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );

    // with assets
    _controller = VideoPlayerController.asset('videos/sample.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(top: 20.0),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                ControlsOverlay(controller: _controller),
                VideoProgressIndicator(_controller, allowScrubbing: true),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
