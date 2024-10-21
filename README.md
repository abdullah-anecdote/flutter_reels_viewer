# Flutter Reels Viewer

[![pub](https://img.shields.io/pub/v/flutter_reels_viewer?logo=dart)](https://pub.dev/packages/flutter_reels_viewer)
![](https://badges.fyi/github/latest-tag/devendroid/flutter_reels_viewer)
![](https://badges.fyi/github/stars/devendroid/flutter_reels_viewer)
![](https://badges.fyi/github/license/devendroid/flutter_reels_viewer)

A highly customizable widget that displays multiple videos in a vertically scrollable list, providing a smooth scrolling experience while watching short videos, similar to platforms like Facebook, Instagram, and YouTube..

## Preview

<img src="https://raw.githubusercontent.com/devendroid/flutter_reels_viewer/master/assets/efab-preview.gif?raw=true" width="320px"/>

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

Simple example for the usage of the package is shown below.

```dart
FlutterReelsViewer.network(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    videoSourceList: VideoRepository.videos,
    preloadPagesCount: 2,
    videoBoxFit: BoxFit.fitWidth,
    onPageChanged: (videoPlayerController, index) {},
    getCurrentVideoController: (videoPlayerController) {},
),
```
## Properties

### **```FlutterReelsViewer```**

| Property |Description| Default |
| --- | ---- | --- |
| icon | Set icon for the FAB | Icons.add |
| color | Set color for the FAB | Colors.blue |
| fabSize | Set size for the FAB | 56 |
| fabMargin | Give margin for the FAB | 0 |
| fabElevation | Set elevation for the FAB | 4 |
| actionButtonSize | Set size for the Action Buttons | 48 |
| actionButtonElevation | Set elevation for the Action Buttons | 4 |
| controller | Set controller to controll programatically |  |
