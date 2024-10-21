library flutter_reels_viewer;

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'reel_view_item.dart';
import 'reel_model.dart';

typedef VideoOverlayWidgetBuilder = Widget Function(
    BuildContext context, int index);

/// Stateful widget to display preloaded videos inside page view.
//ignore: must_be_immutable
class FlutterReelsViewer extends StatefulWidget {
  /// Widget that will show as a overlay on the video
  VideoOverlayWidgetBuilder? overlayBuilder;

  /// enum sourceType values holds the type of source Network, Assets or File
  VideoSource sourceType;

  /// videoSourceList is List or dynamic video sources
  List<dynamic> videoSourceList;

  /// scroll direction of preload page view
  Axis scrollDirection;

  /// number of videos getting initialized defined by preloadPagesCount
  int preloadPagesCount;

  VideoPlayerOptions? videoPlayerOptions;
  Future<ClosedCaptionFile>? closedCaptionFile;
  Map<String, String>? httpHeaders;
  VideoFormat? formatHint;
  String? package;

  bool showControlsOverlay;
  bool showVideoProgressIndicator;

  /// To enable the play in loops,
  /// Note:- This cant be disable if showControlsOverlay property is disable
  bool playInLoop;

  double height;
  double width;
  BoxFit videoBoxFit;

  /// getCurrentVideoController return the current playing video controller
  Function(CachedVideoPlayerController? videoPlayerController)?
      getCurrentVideoController;

  /// onPageChanged calls when swiping through the pages, return
  /// current playing video controller and index
  Function(CachedVideoPlayerController? videoPlayerController, int index)?
      onPageChanged;
  ScrollPhysics? scrollPhysics;
  bool reverse;
  bool pageSnapping;

  /// [PreloadPageView] controller
  PreloadPageController? pageController;

  @override
  State<FlutterReelsViewer> createState() => _FlutterReelsViewerState();

  /// plays videos from list of network video urls
  FlutterReelsViewer.network({
    super.key,
    required this.videoSourceList,
    required this.height,
    required this.width,
    this.videoBoxFit = BoxFit.contain,
    this.overlayBuilder,
    this.scrollDirection = Axis.horizontal,
    this.preloadPagesCount = 1,
    this.videoPlayerOptions,
    this.httpHeaders,
    this.formatHint,
    this.closedCaptionFile,
    this.scrollPhysics,
    this.reverse = false,
    this.pageSnapping = true,
    this.playInLoop = true,
    this.pageController,
    this.getCurrentVideoController,
    this.onPageChanged,
    this.showControlsOverlay = true,
    this.showVideoProgressIndicator = true,
  }) : sourceType = VideoSource.network;

  /// plays videos from list of video files
  FlutterReelsViewer.file({
    super.key,
    required this.videoSourceList,
    required this.height,
    required this.width,
    this.videoBoxFit = BoxFit.contain,
    this.overlayBuilder,
    this.scrollDirection = Axis.horizontal,
    this.preloadPagesCount = 1,
    this.videoPlayerOptions,
    this.httpHeaders,
    this.closedCaptionFile,
    this.scrollPhysics,
    this.reverse = false,
    this.pageSnapping = true,
    this.playInLoop = true,
    this.pageController,
    this.getCurrentVideoController,
    this.onPageChanged,
    this.showControlsOverlay = true,
    this.showVideoProgressIndicator = true,
  }) : sourceType = VideoSource.file;

  /// plays videos from list of asset videos
  FlutterReelsViewer.asset({
    super.key,
    required this.videoSourceList,
    required this.height,
    required this.width,
    this.videoBoxFit = BoxFit.contain,
    this.overlayBuilder,
    this.scrollDirection = Axis.vertical,
    this.preloadPagesCount = 1,
    this.videoPlayerOptions,
    this.package,
    this.closedCaptionFile,
    this.scrollPhysics,
    this.reverse = false,
    this.pageSnapping = true,
    this.playInLoop = true,
    this.pageController,
    this.getCurrentVideoController,
    this.onPageChanged,
    this.showControlsOverlay = true,
    this.showVideoProgressIndicator = true,
  }) : sourceType = VideoSource.asset;
}

class _FlutterReelsViewerState extends State<FlutterReelsViewer> {
  bool isLoading = true;
  List<ReelModal> videosList = [];

  @override
  void initState() {
    super.initState();
    _generateVideoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: widget.height,
        width: widget.width,
        child: videosList.isEmpty
            ? const Center(child: Icon(Icons.error))
            : isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _pageView(),
      ),
    );
  }

  /// [PreloadPageView] initializes more than one videos at time
  PreloadPageView _pageView() {
    return PreloadPageView.builder(
      itemCount: videosList.length,
      physics: widget.scrollPhysics,
      reverse: widget.reverse,
      controller: widget.pageController,
      pageSnapping: widget.pageSnapping,
      scrollDirection: widget.scrollDirection,
      preloadPagesCount: widget.preloadPagesCount > videosList.length
          ? 1
          : widget.preloadPagesCount,
      onPageChanged: (int index) => _onPageChange(index),
      itemBuilder: (context, index) => _child(index),
    );
  }

  /// [VideoPlayer] video player combined with [PreloadPageView]
  ReelViewItem _child(int index) {
    return ReelViewItem(
      videoSource: videosList[index].videoSource,
      videoPosterImage: videosList[index].videoPosterImage,
      index: index,
      sourceType: widget.sourceType,
      videoBoxFit: widget.videoBoxFit,
      overlayBuilder: widget.overlayBuilder,
      videoPlayerOptions: widget.videoPlayerOptions,
      closedCaptionFile: widget.closedCaptionFile,
      showControlsOverlay: widget.showControlsOverlay,
      showVideoProgressIndicator: widget.showVideoProgressIndicator,
      playInLoop: widget.playInLoop,
      onInit: (CachedVideoPlayerController videoPlayerController) {
        if (index == ReelModal.currentIndex) {
          widget.getCurrentVideoController?.call(videoPlayerController);
        }
        videosList[index].updateVideo(
            videoPlayerController: videoPlayerController,
            index: index,
            videoSource: videosList[index].videoSource,
            videoPosterImage: videosList[index].videoPosterImage);
      },
      onDispose: (int index) {
        videosList[index].videoPlayerController = null;
      },
    );
  }

  _onPageChange(int index) {
    ReelModal.currentIndex = index;
    widget.getCurrentVideoController
        ?.call(videosList[index].videoPlayerController);
    widget.onPageChanged?.call(videosList[index].videoPlayerController, index);
    videosList[index].playVideo(index);
  }

  Future<void> _generateVideoList() async {
    for (var source in widget.videoSourceList) {
      if (source is Map) {
        videosList.add(ReelModal(
            videoSource: source['video'] ?? "",
            videoPosterImage: source['image']));
      } else {
        videosList.add(ReelModal(videoSource: source));
      }
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }
}
