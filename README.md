# WeCode Hackathon iOS Jumpstart App

## Overview

This application has been created to eliminate early wasted time setting up a boiler plate code, but also as a potential starting
point for many of the basic things any app does. **It is important to note that this jumpstart app is not the solution
to your problems.  In the words of a fellow dev, "a hackathon is no place to start learning mobile development."**

### What this is

A boiler plate application, using storyboards, with Cocoapods for dependency management and some simple examples of common
user interfaces.  Meant to establish some healthy patterns... maybe save you an hour at the beginning.

### What this is not

A WYSIWYG that will solve all of your problems and make you win a hackathon.  If you are brand new to Xcode, you could lose a day or
two just getting it to work correctly.

### Don't panic, there might still be an option

Included in this example is a WebView.  Using well crafted web pages, you can easily mimick a native mobile UI close enough to realize
your vision.  See instructions below for more information on how to modify this application to launch straight into a webview so you move
straight to hacking mobile websites.

## Components

### Map

The `MapViewController` demonstrates how to:

- Display a map.
- Zoom in on the user's current location.
- Search for another location.
- Zoom in on search result location.
- Setup a basic TableView.

### Video Player

The `VideoViewController` demonstrates how to:

- Display a video from within the app.
- Handle hiding controls when rotating the device.
- Access the URL of a file in the bundle.
- Use an `AVPlayerViewController`.

### Web View

The `WebViewController` demonstrates how to:

- Load a website into a view controller.
- Connect delegates.

## Dependency Management

Dependency management is managed through [CocoaPods](http://cocoapods.org).  You can choose to add dependencies manually, but 
once you step away from cocoapods, you cannot mix approaches.  If you do not know how to use CocoaPods a bit already, today is not 
a good day to learn.

## Modifications

### Adding a tab

To add a tab to the application:

1. Edit Main.storyboard.
2. From the Components Libary, drag a `View Controller` onto the storyboard.
3. From the Components Library, drag a `Tab Bar Item`.
4. Control+Drag from the ViewController that owns the tab bar to the `Item` in the new scene.

### Becoming a Webview Application

To convert this application to launching straight into a webview:

- Delete all interfaces from the storyboard except for the Web interface.  
- Highlight `Web View Controller` and press the Option+Cmd+4 keys to open the attributes inspector
- Check the box `Is Initial View Controller`.
- Edit `WebViewController` and change the `url` property to suit your needs.

## TODO

- Add a watch application
- Add a notification extension
- Add local notifications
- Localization
- Properly portrait mode support

## Icons

Icons used in this jumpstart app are from: https://icons8.com/icon/set/web/ios
