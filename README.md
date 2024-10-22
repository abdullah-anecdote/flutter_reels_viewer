# Flutter Reels Viewer

[![pub](https://img.shields.io/pub/v/flutter_reels_viewer?logo=dart)](https://pub.dev/packages/flutter_reels_viewer)
![](https://badges.fyi/github/latest-tag/devendroid/flutter_reels_viewer)
![](https://badges.fyi/github/stars/devendroid/flutter_reels_viewer)
![](https://badges.fyi/github/license/devendroid/flutter_reels_viewer)

A highly customizable widget that displays multiple videos in a vertically scrollable list, providing a smooth scrolling experience while watching short videos, similar to platforms like Facebook, Instagram, and YouTube..

## Preview

![prev1](https://github.com/devendroid/flutter_reels_viewer/blob/main/assets/prev1.gif)

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
List<dynamic> videos = [
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
    videoSourceList: videos,
    scrollDirection: Axis.vertical,
    preloadPagesCount: 2,
    videoBoxFit: BoxFit.cover,
    playInLoop: true,
    showControlsOverlay: true,
    showVideoProgressIndicator: true,
    onPageChanged: (videoPlayerController, index) {},
    getCurrentVideoController: (videoPlayerController) {},
    overlayBuilder: (context, index) => VideoOverlay(index)
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

| Property | Description                                                                                                               | Default |
|--------|---------------------------------------------------------------------------------------------------------------------------|---|
| height | Set height for Widget   |   |
| width  | Set width for Widget  |   |
| videoSourceList | List or dynamic video sources     |   |
| scrollDirection | Scroll direction of preload page view  | Axis.vertical |
| preloadPagesCount | Number of videos getting initialized defined by preloadPagesCount | 1 |
| videoBoxFit | Set video scaling mode  | BoxFit.fitWidth |
| playInLoop | To play videos in a continuous loop. Note: This feature cannot be disabled if the showControlsOverlay property is turned off. | true |
| showControlsOverlay | Enable play/pause controls on tap of the video  | true |
| showVideoProgressIndicator | Show progress indicator at bottom of the video  | true |
| onPageChanged | Listen to page change with current index  |   |
| getCurrentVideoController | Get current playing video contoller  |   |
| overlayBuilder | Design your own widget that will show as a overlay on the video  |   |


