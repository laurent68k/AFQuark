## Introduction
AFQuark is my first framework available online as a pod with Cocoapod. The goal is to have some nice to have piece of code to help quickly to develop an iOS App.

Currently in dev, don't use it as a pod. It's my playground zone.

## Swift 4.2
Requires Xcode 10 and Swift 4.2.

## Installation
Drop in the AFQuark folder to your Xcode project (make sure to enable "Copy items if needed" and "Create groups").

Or via CocoaPods, seek this GIT repository from your podfile :
```
use_frameworks!
pod 'AFQuark', :git => 'https://github.com/laurent68k/AFQuark.git'
```


## FAAlert Class

func okCancelAlert(_ viewController: UIViewController, title: String, message: String,
                                                okHandler: (() -> Void )? = nil, cancelHandler: (() -> Void )? = nil )
                                          
func okAlert(_ viewController: UIViewController, title: String, message: String, completionHandler: (() -> Void)? = nil)

func toast(_ viewController: UIViewController, title: String, message: String, delaySeconds: Double = 1.0, completionHandler: (() -> Void )? = nil)

func alert(_ viewController: UIViewController, title: String, message: String, withActions actions: [UIAlertAction]?)

func alertSheet(_ viewController: UIViewController, title: String, message: String, forButton anchorObject: Any, withActions actions: [UIAlertAction])


## AFCamera Class (iOS only)

func shoot(_ viewController: UIViewController)

func shareImages(_ viewController: UIViewController, anchorObject: Any, images: [UIImage])


## Extensions

- Date

- String

- UIColor

- UIImage

## Known issue
- None

## Tutorials
- None

## ChangeLog
- None

## License

AFQuark is released under the MIT license. See LICENSE for details.

