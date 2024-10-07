import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minimal_flutter_app/model/audio.dart';
import 'package:minimal_flutter_app/model/m3u8.dart';
import 'package:minimal_flutter_app/model/m3u8s.dart';
import 'package:minimal_flutter_app/responses/regex_response.dart';
import 'package:minimal_flutter_app/screens/video_controls_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final void Function(String videoType)? onPlayingVideo;
  const HomePage({super.key, this.onPlayingVideo});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoPlayerController _controller;
  List<M3U8pass> yoyo = [];
  List<AUDIO> audioList = [];
  String? m3u8Content;
  bool? offline;
  String? playType;
  bool hasInitError = false;
  VideoPlayerController? controller;

  @override
  void initState() {
    urlCheck(
        "https://hls126.dsaqtqpt.pro/streamhls2024/33e945737d702c306fa8f0cfa79bc81e/ep.12.v1.1716891473.1080.m3u8");
    super.initState();
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    //   videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    // );

    // with assets
    // _controller = VideoPlayerController.asset('videos/sample.mp4');

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    m3u8clean();
    _controller.dispose();
    super.dispose();
  }

  void m3u8clean() async {
    // print(yoyo.length);
    for (int i = 2; i < yoyo.length; i++) {
      try {
        final Directory directory = await getApplicationDocumentsDirectory();
        final File file = File('${directory.path}/${yoyo[i].dataQuality}.m3u8');
        file.delete();
        // print("delete success $file");
      } catch (e) {
        // print("Couldn't delete file $e");
      }
    }
    try {
      audioList.clear();
    } catch (e) {
      // print("Audio list clean error $e");
    }
    audioList.clear();
    try {
      // print("m3u8 data list clean");
      yoyo.clear();
    } catch (e) {
      // print("m3u8 video list clean error $e");
    }
  }

  // M3U8 Data Setup
  void getM3U8(String video) {
    if (yoyo.isNotEmpty) {
      print("${yoyo.length} : data start clean");
      m3u8clean();
    }
    print("---- m3u8 fitch start ----\n$video\n--- please wait –––");
    m3u8video(video);
  }

  void urlCheck(String url) {
    final netRegex = RegExp(r'^(http|https):\/\/([\w.]+\/?)\S*');
    final isNetwork = netRegex.hasMatch(url);
    final a = Uri.parse(url);

    print("parse url data end : ${a.pathSegments.last}");
    if (isNetwork) {
      setState(() {
        offline = false;
      });
      if (a.pathSegments.last.endsWith("mkv")) {
        setState(() {
          playType = "MKV";
        });
        print("urlEnd : mkv");
        if (widget.onPlayingVideo != null) widget.onPlayingVideo!("MKV");

        videoControlSetup(url);
      } else if (a.pathSegments.last.endsWith("mp4")) {
        setState(() {
          playType = "MP4";
        });
        print("urlEnd : mp4 $playType");
        if (widget.onPlayingVideo != null) widget.onPlayingVideo!("MP4");

        print("urlEnd : mp4");
        videoControlSetup(url);
      } else if (a.pathSegments.last.endsWith("m3u8")) {
        setState(() {
          playType = "HLS";
        });
        if (widget.onPlayingVideo != null) widget.onPlayingVideo!("M3U8");

        print("urlEnd : m3u8");
        videoControlSetup(url);
        getM3U8(url);
      } else {
        print("urlEnd : null");
        videoControlSetup(url);
        getM3U8(url);
      }
      print("--- Current Video Status ---\noffline : $offline");
    } else {
      setState(() {
        offline = true;
        print(
            "--- Current Video Status ---\noffline : $offline \n --- :3 done url check ---");
      });
      videoControlSetup(url);
    }
  }

  Future<M3U8s> m3u8video(String video) async {
    yoyo.add(M3U8pass(dataQuality: "Auto", dataURL: video));
    RegExp regExpAudio = RegExp(
      RegexResponse.regexMEDIA,
      caseSensitive: false,
      multiLine: true,
    );
    RegExp regExp = RegExp(
      r"#EXT-X-STREAM-INF:(?:.*,RESOLUTION=(\d+x\d+))?,?(.*)\r?\n(.*)",
      caseSensitive: false,
      multiLine: true,
    );
    setState(
      () {
        if (m3u8Content != null) {
          // print("--- HLS Old Data ----\n$m3u8Content");
          m3u8Content = null;
        }
      },
    );
    if (m3u8Content == null) {
      http.Response response = await http.get(Uri.parse(video));
      if (response.statusCode == 200) {
        m3u8Content = utf8.decode(response.bodyBytes);
      }
    }
    List<RegExpMatch> matches = regExp.allMatches(m3u8Content!).toList();
    List<RegExpMatch> audioMatches =
        regExpAudio.allMatches(m3u8Content!).toList();
    print(
        "--- HLS Data ----\n$m3u8Content \ntotal length: ${yoyo.length} \nfinish");

    matches.forEach(
      (RegExpMatch regExpMatch) async {
        String quality = (regExpMatch.group(1)).toString();
        String sourceURL = (regExpMatch.group(3)).toString();
        final netRegex = RegExp(r'^(http|https):\/\/([\w.]+\/?)\S*');
        final netRegex2 = RegExp(r'(.*)\r?\/');
        final isNetwork = netRegex.hasMatch(sourceURL);
        final match = netRegex2.firstMatch(video);
        String url;
        if (isNetwork) {
          url = sourceURL;
        } else {
          print(match);
          final dataURL = match!.group(0);
          url = "$dataURL$sourceURL";
          print("--- hls child url integration ---\nchild url :$url");
        }
        audioMatches.forEach(
          (RegExpMatch regExpMatch2) async {
            String audioURL = (regExpMatch2.group(1)).toString();
            final isNetwork = netRegex.hasMatch(audioURL);
            final match = netRegex2.firstMatch(video);
            String auURL = audioURL;
            if (isNetwork) {
              auURL = audioURL;
            } else {
              print(match);
              final auDataURL = match!.group(0);
              auURL = "$auDataURL$audioURL";
              print("url network audio  $url $audioURL");
            }
            audioList.add(AUDIO(url: auURL));
            print(audioURL);
          },
        );
        String audio = "";
        print("-- audio ---\naudio list length :${audio.length}");
        if (audioList.isNotEmpty) {
          audio =
              """#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio-medium",NAME="audio",AUTOSELECT=YES,DEFAULT=YES,CHANNELS="2",URI="${audioList.last.url}"\n""";
        } else {
          audio = "";
        }
        try {
          final Directory directory = await getApplicationDocumentsDirectory();
          final File file = File('${directory.path}/yoyo$quality.m3u8');
          await file.writeAsString(
              """#EXTM3U\n#EXT-X-INDEPENDENT-SEGMENTS\n$audio#EXT-X-STREAM-INF:CLOSED-CAPTIONS=NONE,BANDWIDTH=1469712,RESOLUTION=$quality,FRAME-RATE=30.000\n$url""");
        } catch (e) {
          print("Couldn't write file");
        }
        yoyo.add(M3U8pass(dataQuality: quality, dataURL: url));
      },
    );
    M3U8s m3u8s = M3U8s(m3u8s: yoyo);
    print(
        "--- m3u8 file write ---\n${yoyo.map((e) => e.dataQuality == e.dataURL).toList()}\nlength : ${yoyo.length}\nSuccess");
    return m3u8s;
  }

  void videoInit(String? url) {
    if (offline == false) {
      print(
          "--- Player Status ---\nplay url : $url\noffline : $offline\n--- start playing –––");

      if (playType == "MP4") {
        // Play MP4
        _controller =
            VideoPlayerController.network(url!, formatHint: VideoFormat.other)
              ..initialize();
      } else if (playType == "MKV") {
        _controller =
            VideoPlayerController.network(url!, formatHint: VideoFormat.dash)
              ..initialize();
      } else if (playType == "HLS") {
        _controller =
            VideoPlayerController.network(url!, formatHint: VideoFormat.hls)
              ..initialize()
                  .then((_) => setState(() => hasInitError = false))
                  .catchError((e) => setState(() => hasInitError = true));
        print("hls type");
      }
    } else {
      print(
          "--- Player Status ---\nplay url : $url\noffline : $offline\n--- start playing –––");
      _controller = VideoPlayerController.file(File(url!))
        ..initialize()
            .then((value) => setState(() => hasInitError = false))
            .catchError((e) => setState(() => hasInitError = true));
    }
  }

  // Video controller
  void videoControlSetup(String? url) {
    videoInit(url);
    // controller!.addListener(listener);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    // final videoChildren = <Widget>[
    //   GestureDetector(
    //     onTap: () {
    //       toggleControls();
    //     },
    //     onDoubleTap: () {
    //       togglePlay();
    //     },
    //     child: ClipRect(
    //       child: Container(
    //         width: double.infinity,
    //         height: double.infinity,
    //         color: Colors.black,
    //         child: Center(
    //             child: AspectRatio(
    //           aspectRatio: controller!.value.aspectRatio,
    //           child: VideoPlayer(controller!),
    //         )),
    //       ),
    //     ),
    //   ),
    // ];
    // videoChildren.addAll(videoBuiltInChildren());
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
