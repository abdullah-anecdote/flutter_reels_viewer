# Flutter Reels Viewer

[![pub](https://img.shields.io/pub/v/flutter_reels_viewer?logo=dart)](https://pub.dev/packages/flutter_reels_viewer)
![](https://badges.fyi/github/latest-tag/devendroid/flutter_reels_viewer)
![](https://badges.fyi/github/stars/devendroid/flutter_reels_viewer)
![](https://badges.fyi/github/license/devendroid/flutter_reels_viewer)

A highly customizable widget that displays multiple videos in a vertically scrollable list, providing a smooth scrolling experience while watching short videos, similar to platforms like Facebook, Instagram, and YouTube..

## Preview

![prev1](https://github.com/devendroid/flutter_reels_viewer/blob/main/assets/prev1.gif)
![prev2](https://github.com/devendroid/flutter_reels_viewer/blob/main/assets/prev2.gif)
![prev3](https://github.com/devendroid/flutter_reels_viewer/blob/main/assets/prev3.gif)

## Demo APK

[Click here](https://github.com/devendroid/flutter_reels_viewer/blob/master/assets/reels_viewer.apk) for download demo app.


## Instalation

* Add the latest version of the package to your pubspec.yaml file in the dependency section.

```yaml
  dependencies:
    flutter:
      sdk: flutter

    flutter_reels_viewer: ^1.0.0
```
Run this in your terminal

```sh
$ flutter pub get
```

## How to use

#### Video list can contain either only videos.

```dart
List<dynamic> videos = [
  'https://assets.mixkit.co/videos/39767/39767-720.mp4',
  'https://assets.mixkit.co/videos/34487/34487-720.mp4',
  'https://assets.mixkit.co/videos/34404/34404-720.mp4'
];
```
#### Or videos with poster image.

```dart
List<dynamic> videosWithImage = [
  {
    'video': 'https://assets.mixkit.co/videos/39767/39767-720.mp4',
    'image': 'https://assets.mixkit.co/videos/39767/39767-thumb-360-0.jpg'
  },
  {
    'video': 'https://assets.mixkit.co/videos/34487/34487-720.mp4',
    'image': 'https://assets.mixkit.co/videos/34487/34487-thumb-360-0.jpg'
  },
  {
    'video': 'https://assets.mixkit.co/videos/34404/34404-720.mp4',
    'image': 'https://assets.mixkit.co/videos/34404/34404-thumb-360-0.jpg'
  },
];
```

#### Then simple example

```dart
FlutterReelsViewer.network(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    videoSourceList: videos, // OR videosWithImage
    scrollDirection: Axis.vertical,
    preloadPagesCount: 2,
    videoBoxFit: BoxFit.cover,
    playInLoop: true,
    showControlsOverlay: true,
    showVideoProgressIndicator: true,
    onPageChanged: (videoPlayerController, index) {},
    getCurrentVideoController: (videoPlayerController) {},
    overlayBuilder: (context, index) => MyCustomVideoOverlay(index)
);
```
## Variant

| Variant                        | Description                                  |
|--------------------------------|----------------------------------------------|
| FlutterReelsViewer.network(...) | Plays videos from list of network video urls |
| FlutterReelsViewer.asset(...)  | Plays videos from list of asset videos       |
| FlutterReelsViewer.file(...)   | Plays videos from list of video files        |

## Properties

### **```FlutterReelsViewer(...)```**

| Type                                 | Property | Description                                                                                                               | Default |
|--------------------------------------|--------|---------------------------------------------------------------------------------------------------------------------------|---|
| *double*                             | height | Set height for Widget   |   |
| *double*                             | width  | Set width for Widget  |   |
| *List< dynamic >*                    | videoSourceList | List or dynamic video sources     |   |
| [*Axis*][axis]                       | scrollDirection | Scroll direction of preload page view  | Axis.vertical |
| *int*                                | preloadPagesCount | Number of videos getting initialized defined by preloadPagesCount | 1 |
| [*ScrollPhysics*][scroll]            | scrollPhysics | How the page view should respond to user input | Platform conventions |
| *bool*                               | pageSnapping | Set to false to disable page snapping | true |
| *bool*                               | reverse | Whether the page view scrolls in the reading direction | false |
| [*PreloadPageController*][preload]   | pageController | To get more control on PreloadPageView |  |
| [*BoxFit*][box]                      | videoBoxFit | Set video scaling mode  | BoxFit.fitWidth |
| *bool*                               | playInLoop | To play videos in a continuous loop. Note: This feature cannot be disabled if the showControlsOverlay property is turned off. | true |
| [*VideoPlayerOptions*][player]       | videoPlayerOptions | Provide additional configuration options (optional). Like setting the audio mode to mix  |  |
| *Future< [ClosedCaptionFile][ccf] >* | closedCaptionFile | Optional field to specify a file containing the closed captioning |  |
| *Map< String, String >*              | httpHeaders | HTTP headers can be used only for [VideoPlayerController.network]  |  |
| [*VideoFormat*][format]              | formatHint | **Android only**. Will override the platform's generic file format  | true |
| *String*                             | package | Only set for [asset] videos. The package that the asset was loaded from  | true |
| *bool*                               | showControlsOverlay | Enable play/pause controls on tap of the video  | true |
| *bool*                               | showVideoProgressIndicator | Show progress indicator at bottom of the video  | true |
| *Functoin(controller, index)*        | onPageChanged | Listen to page change with current index  |   |
| *Function(controller)*               | getCurrentVideoController | Get current playing video contoller  |   |
| *Function(context, index)*           | overlayBuilder | Design your own widget that will show as a overlay on the video  |   |


[axis]:https://api.flutter.dev/flutter/painting/Axis.html
[scroll]:https://api.flutter.dev/flutter/widgets/ScrollPhysics-class.html
[preload]:https://pub.dev/documentation/preload_page_view/latest/preload_page_view/PreloadPageController-class.html
[box]:https://api.flutter.dev/flutter/painting/BoxFit.html
[player]:https://pub.dev/documentation/video_player_platform_interface/latest/video_player_platform_interface/VideoPlayerOptions-class.html
[ccf]:https://pub.dev/documentation/video_player/latest/video_player/ClosedCaptionFile-class.html
[format]:https://pub.dev/documentation/video_player/latest/video_player/VideoFormat.html