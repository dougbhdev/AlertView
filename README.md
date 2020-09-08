## AlertView

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action) [![Language](http://img.shields.io/badge/swift-5.1-orange.svg?style=flat
)](https://developer.apple.com/swift)

## Requirements

- Swift 5.1
- Xcode 10.1 or greater
- iOS 11 or greater

## Author

Douglas Nunes, dougbhdev@gmail.com

## Usage

```swift
let config = AlertViewBuilder()
```

### Supported Attributes AlertViewBuilder

| Description      | Default value  |
|-------------| -----|
| withIcon(_ image: UIImage?)     | not value Default |
| withTitle(_ title: String?)     | not value Default |
| withMessage(_ message: String?)   | not value Default |
| withMessage(_ message: NSAttributedString?)     | not value Default |
| withTextAlign(_ alignment: NSTextAlignment)    | .center |
| withTapDismiss(_ tap: Bool)     | true |
| withEnableVibrate(_ enable: Bool)     | true |
| withCancelButtonTitle(_ title: String?)     | not value Default |
| withDoneButtonTitle(_ title: String?)     | not value Default |
| withTitleColorButtonDone(_ color: UIColor)     | .white |
| withBackgroundColorButtonDone(_ color: UIColor)    | UIColor(red: 0.03, green: 0.31, blue: 0.62, alpha: 1) |
| withTitleColorButtonCancel(_ color: UIColor)     | .white |
| withBackgroundColorButtonCancel(_ color: UIColor)     | .red |

###Configuration file declaration

```swift
let config = AlertViewBuilder()
            .withTitle("Parceiro Ambev alerta!")
            .withTextAlign(.center)
            .withTapDismiss(true)
            .withCancelButtonTitle("Cancel")
            .withDoneButtonTitle("Confirm")
            .build()
```

```swift
 let alert = CustomAlertView()
```

AlertView component declaration with Button Cancel and Done.

```swift
alert.show(config: config,
                   doneAction: {
                    print("Click in Confirm")
        }, cancelAction: {
            print("Click in Cancel")
        })
```

AlertView component declaration with Button Done.
```swift
alert.show(config: config,
                   doneAction: {
                    print("Click in Confirmar")
        })
```

