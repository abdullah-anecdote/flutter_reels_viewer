import 'package:cached_video_player/cached_video_player.dart';

enum VideoSource { network, file, asset }

class ReelModal {
  /// holds current page index for preload preview
  static int currentIndex = 0;

  /// source for video network, file or asset
  dynamic videoSource;

  /// video Poster image to show until video is loads
  String? videoPosterImage;

  /// page index associated with video
  int index;

  /// video player controller
  CachedVideoPlayerController? videoPlayerController;

  /// creates a video model
  /// [videoSource] must not be null
  ReelModal(
      {required this.videoSource,
      this.videoPosterImage,
      this.videoPlayerController,
      this.index = 0});

  /// plays current video
  void playVideo(int index) {
    /// if [currentIndex] and video [index] matches while swiping through videos
    /// it plays the video
    if (index == currentIndex) {
      if (videoPlayerController != null) {
        videoPlayerController?.play();
      }
    }
  }

  /// updates [videoPlayerController], [videoSource], [videoPosterImage] and [index] when video get initialized
  void updateVideo(
      {videoSource, videoPlayerController, videoPosterImage, index}) {
    this.videoPlayerController = videoPlayerController;
    this.videoSource = videoSource;
    this.videoPosterImage = videoPosterImage;
    this.index = index;
  }
}
