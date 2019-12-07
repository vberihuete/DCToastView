# DCToast


A Toast View made in swift using auto layout and stack views.

![sample gif](https://media.giphy.com/media/iAQniXu33l8LvPPjQO/giphy.gif)

## Requirements

iOS 11 or above and swift 4.2

## Installation

DCToastView is available through Swift package manager. To install
it, simply add this git repository into your xcode spm depenencies:

## How to

After you have your cocoapods set up done and already added the pod for DCToastView, you just need to import in the View Controller you will like to use the Filter View.

```swift
import DCToast
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
