
[![CI Status](http://img.shields.io/travis/shoheiyokoyama/Gemini.svg?style=flat)](https://travis-ci.org/shoheiyokoyama/Gemini)
[![Version](https://img.shields.io/cocoapods/v/Gemini.svg?style=flat)](http://cocoapods.org/pods/Gemini)
[![License](https://img.shields.io/cocoapods/l/Gemini.svg?style=flat)](http://cocoapods.org/pods/Gemini)
[![Platform](https://img.shields.io/cocoapods/p/Gemini.svg?style=flat)](http://cocoapods.org/pods/Gemini)

# Overview

<img src="./Resources/demo-circle-rotation.gif" align="left">

## What is the `Gemini`?

`Gemini` is rich scroll animation framework for iOS, written in Swift. You can easily use `GeminiCollectionView`, which is a subclass of `UICollectionView`.

You available multiple animation has various and customizable properties, and moreover can create your own custom scroll animation. 

`Gemini` also provide a fluent interface based on method chaining. you can use this intuitvely and simply.


```swift
collectionView.gemini
    .circleRotationAnimation()
    .radius(400)
    .rotateDirection(.clockwise)
```

# Features

<img src="./Resources/demo-yaw-rotation.gif" align="right">

- [x] Rich animation with scrolling
- [x] Easily usable
- [x] Highly customizable
- [x] Several types of animations and properties
- [x] Support vertical and horizontal flow layout
- [x] Support easing function
- [x] Support `Swift3`
- [x] Fluent interfaces based on method chaining
- [x] Compatible with `Carthage`
- [x] Compatible with `CocoaPod`
- [x] Completely Example Project
- [x] Completely `README`
- [x] And More...

# Animation Types
- [Cube](#cube)
- [Circle Rotation](#circle-rotation) You can configure rotation direction using the `CircleRotationDirection`
- [3D vector rotation](#3d-vector-rotation) Each rotation types provide multiple rotation effect
  - [Roll Rotation](#roll-rotation)
  - [Pitch Rotation](#pitch-rotation)
  - [Yaw Rotation](#yaw-rotation)
- Shadow Effect 
- [Scale](#scale)
- BackgroundColor
- CornerRadius
- Alpha
- [Custom](#custom) you can create your own custom scroll animation using multiple properties, rotation, scale, translation, etc.

## <a name="cube"> Cube

<p align="center">
  <img src="./Resources/cube-horizontal.gif">
  <img src="./Resources/cube-vertical.gif">
</p>

## <a name="circle-rotation"> CircleRotation

<p align="center">
  <img src="./Resources/circle-horizontal.gif">
  <img src="./Resources/circle-vertical.gif">
</p>

## <a name="3d-vector-rotation"> 3D vector rotation

### <a name="roll-rotation"> Roll Rotation

<p align="center">
  <img src="./Resources/roll-horizontal.gif">
  <img src="./Resources/roll-vertical.gif">
</p>

### <a name="pitch-rotation"> Pitch Rotation

<p align="center">
  <img src="./Resources/pitch-horizontal.gif">
  <img src="./Resources/pitch-vertical.gif">
</p>

### <a name="yaw-rotation"> Yaw Rotation

<p align="center">
  <img src="./Resources/yaw-horizontal.gif">
  <img src="./Resources/yaw-vertical.gif">
</p>

## <a name="scale"> Scale

<p align="center">
  <img src="./Resources/scale-up.gif">
  <img src="./Resources/scale-down.gif">
</p>

## <a name="custom"> Custom

<p align="center">
  <img src="./Resources/custom1.gif">
  <img src="./Resources/custom2.gif">
</p>


# Usage

1. ***Use Gemini classes***

`Gemini` is designed to be easy to use. Use `GeminiCollectionView` and `GeminiCell`. These classes is subclass of `UICollectionView`, `UICollectionViewCell`.

2. ***Configure animation***

Configure animation with fluent interface based on method chaining. You can develop expressive code that enhances readability.

3. ***Call function for animation***

Finally, call `animateVisibleCells()` in `scrollViewDidScroll(_:)`

> NOTE: If you want to adapt animation immediately after view is displayed, call `animateCell(_:)` in `collectionView(_:cellForItemAt:)` and `collectionView(_:willDisplay:forItemAt:)`.


```swift
/// Import Gemini
import Gemini

/// Inherite GeminiCell
class CustomCell: GeminiCell {
...


class CustomViewController: UIViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    /// Inherite GeminiCollectionView
    @IBOutlet fileprivate weak var collectionView: GeminiCollectionView!

...

    /// Configure animation and properties
    func configureAnimation() {
        collectionView.gemini
            .circleRotationAnimation()
            .radius(400)
            .rotateDirection(.clockwise)
    }

    /// Call animation function
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        self.collectionView.animateCell(cell)
        return cell
    }
```

See [Example](https://github.com/shoheiyokoyama/Gemini/tree/master/Example/Gemini), for more details.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Gemini is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Gemini"
```

## Author

shoheiyokoyama, shohei.yok0602@gmail.com

## License

Gemini is available under the MIT license. See the LICENSE file for more info.
