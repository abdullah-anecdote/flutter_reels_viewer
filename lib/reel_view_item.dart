import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';

import 'flutter_reels_viewer.dart';
import 'reel_model.dart';

/// Stateful widget to fetch and then display video content.
/// ignore: must_be_immutable
class ReelViewItem extends StatefulWidget {
  VideoOverlayWidgetBuilder? overlayBuilder;
  dynamic videoSource;
  String? videoPosterImage;
  BoxFit videoBoxFit;
  int index;
  Function(CachedVideoPlayerPlusController controller) onInit;
  Function(int index) onDispose;
  VideoPlayerOptions? videoPlayerOptions;
  VideoSource sourceType;
  Future<ClosedCaptionFile>? closedCaptionFile;
  Map<String, String>? httpHeaders;
  VideoFormat? formatHint;
  String? package;
  bool showControlsOverlay;
  bool showVideoProgressIndicator;
  bool show = true;
  bool playInLoop;

  ReelViewItem({
    super.key,
    required this.videoSource,
    this.videoPosterImage,
    required this.videoBoxFit,
    this.overlayBuilder,
    required this.index,
    required this.onInit,
    required this.onDispose,
    this.videoPlayerOptions,
    this.closedCaptionFile,
    this.httpHeaders,
    this.formatHint,
    this.package,
    this.showControlsOverlay = true,
    this.showVideoProgressIndicator = true,
    required this.playInLoop,
    required this.sourceType,
  });

  @override
  State<ReelViewItem> createState() => _ReelViewItemState();
}

class _ReelViewItemState extends State<ReelViewItem> {
  late CachedVideoPlayerPlusController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  /// initializes videos
  void _initializeVideo() {
    if (widget.sourceType == VideoSource.network) {
      _controller = CachedVideoPlayerPlusController.networkUrl(
        Uri.parse(widget.videoSource.toString()),
        videoPlayerOptions: widget.videoPlayerOptions,
        closedCaptionFile: widget.closedCaptionFile,
        httpHeaders: widget.httpHeaders ?? {},
        formatHint: widget.formatHint,
      );
    } else if (widget.sourceType == VideoSource.asset) {
      _controller = CachedVideoPlayerPlusController.asset(
        widget.videoSource,
        videoPlayerOptions: widget.videoPlayerOptions,
        closedCaptionFile: widget.closedCaptionFile,
        package: widget.package,
      );
    } else if (widget.sourceType == VideoSource.file) {
      _controller = CachedVideoPlayerPlusController.file(
        widget.videoSource,
        videoPlayerOptions: widget.videoPlayerOptions,
        closedCaptionFile: widget.closedCaptionFile,
      );
    }

    _controller.initialize().then((_) {
      widget.onInit.call(_controller);
      _controller.setLooping(widget.playInLoop || !widget.showControlsOverlay);
      if (widget.index == ReelModal.currentIndex) {
        _controller.play();
      }
      _controller.addListener(() => _videoListener());
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? _PosterOrLoader(widget.videoPosterImage, widget.videoBoxFit)
          : _controller.value.isInitialized
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Center(
                        child: SizedBox.expand(
                      child: FittedBox(
                        fit: widget.videoBoxFit,
                        child: SizedBox(
                          width: _controller.value.size.width,
                          height: _controller.value.size.height,
                          child: CachedVideoPlayerPlus(
                            _controller,
                          ),
                        ),
                      ),
                    )),
                    widget.showControlsOverlay
                        ? _ControlsOverlay(controller: _controller)
                        : const SizedBox.shrink(),
                    widget.showVideoProgressIndicator
                        ? VideoProgressIndicator(_controller,
                            allowScrubbing: true)
                        : const SizedBox.shrink(),
                    widget.overlayBuilder != null
                        ? widget.overlayBuilder!(context, widget.index)
                        : const SizedBox.shrink()
                  ],
                )
              : const SizedBox.shrink(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    widget.onDispose.call(widget.index);
  }

  _videoListener() {
    if (widget.index != ReelModal.currentIndex) {
      if (_controller.value.isInitialized) {
        if (_controller.value.isPlaying) {
          _controller.pause();
        }
      }
    }
    setState(() {});
  }
}

class _PosterOrLoader extends StatelessWidget {
  final String? posterImage;
  final BoxFit? imageBoxFit;

  const _PosterOrLoader(this.posterImage, this.imageBoxFit);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: (posterImage?.isNotEmpty == true)
            ? CachedNetworkImage(
                imageUrl: posterImage!,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const SizedBox.shrink(),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: imageBoxFit,
                    ),
                  ),
                ),
              )
            : const CircularProgressIndicator());
  }
}

class _ControlsOverlay extends StatefulWidget {
  const _ControlsOverlay({required this.controller});

  final CachedVideoPlayerPlusController controller;

  @override
  State<_ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<_ControlsOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.value.isPlaying
                  ? widget.controller.pause()
                  : widget.controller.play();
            });
          },
        ),
      ],
    );
  }
}
