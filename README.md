[![Build Status](https://travis-ci.org/notbenoit/StepColor.svg)](https://travis-ci.org/notbenoit/StepColor)

# StepColor
StepColor is a iOS/MacOS framework to pick a precise color in a given gradient (imagine picking a `UIColor`/`NSColor` from a `CGGradient` at any location).


## Requirements

- iOS 7.0+ / Mac OS X 10.9+
- Xcode 6.1

## Installation

### CocoaPods
[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 beta adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods --pre
```

To add `StepColor` to your project, add this line to your  `Podfile` (WIP on develop branch) :

```ruby
pod 'StepColor', :git => 'https://github.com/notbenoit/StepColor.git', :branch => 'develop'
```

### Manual
- Simple add the `StepColor.xcodeproj` to your workspace and add its output as a dependency of your project.
- You can also build the framework version you need (iOS/Mac) and directly link the framework to your target.

## Usage
The SColor object acts like a gradient in CoreGraphics. The first color is located at the step `0.0`, and the last one is at `1.0`. You can set any number of colors at any step (since each step is a key in a map, you can't have twice the same step but you can have the same color at different steps).

To use StepColor, simply create a `SColor` object and pick the color you need.

### Creating a SColor
There are several ways you can create a SColor.

- With an inifinite list of UIColor/NScolor :


```swift
SColor(colors: NSColor.redColor(), NSColor.blueColor(), NSColor.orangeColor)
```

The colors will be evenly spread between the start (0.0) and end (1.0) of the gradient.

- With an array of colors and the corresponding steps :

```swift
SColor(colors: [NSColor.redColor(), NSColor.blueColor()], steps: [0.3, 0.9])
```

Note that from step 0 to 0.3, the color will be `redColor`. The same way, from 0.9 to 1.0 the color will be `blueColor`.
You must provide exactly the same number of colors and step when you inkoke this initalizer, or you will trigger an exception.

### Picking a color
There is a single method to pick a color (UIColor or NSColor depending on your platform).

```swift
let stepColor = SColor(colors: [NSColor.redColor(), NSColor.blueColor()], steps: [0.0, 1.0])
let halfColor = stepColor.colorForStep(0.5)
```

By picking the color at 0.5, the color will be half way between red and blue (purple ?).

### Usage ideas
You can use this framework for several reasons :

- Implement an `UIProgressBar` subclass that changes color as the progress updates.
- Emphasis on the importance of some items over others in a `UICollectionView`.
- Display pretty rows in a UITableView with a changing `backgroundColor`.

## Creator

- [Benoît Layer](http://github.com/notbenoit) ([@notbenoit](https://twitter.com/notbenoit))

## License

StepColor is released under the MIT license. See LICENSE for details.
