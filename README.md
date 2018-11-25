# DCToastView

[![CI Status](https://img.shields.io/travis/vberihuete/DCToastView.svg?style=flat)](https://travis-ci.org/vberihuete/DCToastView)
[![Version](https://img.shields.io/cocoapods/v/DCToastView.svg?style=flat)](https://cocoapods.org/pods/DCToastView)
[![License](https://img.shields.io/cocoapods/l/DCToastView.svg?style=flat)](https://cocoapods.org/pods/DCToastView)
[![Platform](https://img.shields.io/cocoapods/p/DCToastView.svg?style=flat)](https://cocoapods.org/pods/DCToastView)

A Toast View made in swift using auto layout and stack views.

![sample gif](https://media.giphy.com/media/d5pSYtMrpkp2XDO6ev/giphy.gif)

## Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 11 or above and swift 4.2

## Installation

DCToastView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DCToastView'
```

## How to

After you have your cocoapods set up done and already added the pod for DCToastView, you just need to import in the View Controller you will like to use the Filter View.

```swift
import DCToastView
```

Then just call the shared Toast Presenter instance to show or remove a toast message 

```swift
ToastPresenter.shared.show(in: self.view, message: "This is a toast")
```


```swift
ToastPresenter.shared.remove()
```

Constructor properties go as follows:

* **view**: The view in which the toast is going to be presented
* **message**: The message that the toast will show
* **toastPlace**: The place which can be .down or .up
* **backgroundColor**: The background color of the toast; defaults to black
* **textColor**: The text color of the message; defaults to white
* **timeOut**: The amount of seconds for the toast to dismiss if not provided it means that the toast will be sticky (will remain until touched); defaults to nil
* **roundness**: How round the toast will be: .none, .low, .mid, .high; defaults to .mid


## Author

Vincent Berihuete, vberihuete@gmail.com

## License

DCToastView is available under the MIT license. See the LICENSE file for more info.
