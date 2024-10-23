import 'package:flutter/material.dart';
import 'package:flutter_reels_viewer/flutter_reels_viewer.dart';
import 'package:flutter_reels_viewer_example/video_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body:
        FlutterReelsViewer.network(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            videoSourceList: VideoRepository.videosWithPoster,
            scrollDirection: Axis.vertical,
            preloadPagesCount: 2,
            videoBoxFit: BoxFit.cover,
            playInLoop: true,
            showControlsOverlay: true,
            showVideoProgressIndicator: true,
            onPageChanged: (videoPlayerController, index) {},
            getCurrentVideoController: (videoPlayerController) {},
            overlayBuilder: (context, index) => MyCustomVideoOverlay(index))
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class MyCustomVideoOverlay extends StatelessWidget {
  final int index;

  const MyCustomVideoOverlay(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          "https://generated.photos/vue-static/home/hero/${(index % 8) + 1}.png"),
                    ),
                    const SizedBox(
                      width: 8.00,
                    ),
                    Text(
                      "@User Name $index",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  "A Flutter widget that displays multiple videos in a vertically scrollable list, providing a smooth scrolling experience while watching short videos...",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 20,
            direction: Axis.vertical,
            children: [
              IconText(
                  const Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 38.0,
                  ),
                  "234",
                  () {}),
              IconText(
                  const Icon(
                    Icons.comment,
                    color: Colors.white,
                    size: 38.0,
                  ),
                  "57",
                  () {}),
              IconText(
                  const Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 38.0,
                  ),
                  "342",
                  () {}),
              const Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 38.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function onPressed;

  const IconText(this.icon, this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () => onPressed,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
