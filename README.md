# 📌 Pushover

[![Travis](https://img.shields.io/travis/kiliankoe/pushover.svg?style=flat-square)](https://travis-ci.org/kiliankoe/pushover)
[![Version](https://img.shields.io/cocoapods/v/Pushover.svg?style=flat-square)](http://cocoapods.org/pods/Pushover)
[![License](https://img.shields.io/cocoapods/l/Pushover.svg?style=flat-square)](http://cocoapods.org/pods/Pushover)
[![Platform](https://img.shields.io/cocoapods/p/Pushover.svg?style=flat-square)](http://cocoapods.org/pods/Pushover)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/Pushover.svg?style=flat-square)](http://cocoadocs.org/docsets/Pushover)
[![Codecov](https://img.shields.io/codecov/c/github/kiliankoe/pushover.svg?style=flat-square)](https://codecov.io/gh/kiliankoe/pushover)

Simple little wrapper for the [Pushover](https://pushover.net) API. Use it to send push notifications from your tools to your or your user's devices.

## Example

```swift
// Create a pushover object with your API token.
let pushover = Pushover(token: "YOUR_TOKEN")

// Send a simple message directly.
pushover.send("Lorem ipsum dolor sit amet.", to: "USER_OR_GROUP_KEY")

// Use `Notification`s to use more of Pushover's features.
var notification = Notification(message: "Lorem ipsum.", to: "USER")
						.devices(["iPhone"])
						.url("https://example.com")
						.urlTitle("Dolor sit amet")
						.priority(.high)
						.sound(.intermission)
pushover.send(notification)

// Use the callback to define actions based on error or success cases.
pushover.send(notification) { result in
	// A .success result case means that there were no network, server or decoding errors.
	// The request might still have failed due to a wrong API token, exceeded limits or
	// other problems. Be sure to check the response value for more information.
}
```

## Requirements

You're going to need an API token, you can register for one [here](https://pushover.net/apps/build).

Also please read the *[Being Friendly to our API](https://pushover.net/api#friendly)* section in the Pushover API docs.

## Installation

Pushover is available through Cocoapods. To install it, simply add the following line to your Podfile:

```ruby
pod 'Pushover'
```

You can also use Swift Package Manager. For that, add the following to your dependencies in your Package.swift:

```swift
.Package(url: "https://github.com/kiliankoe/pushover", majorVersion: 0)
```

It should also be available via Carthage/Punic, although I have not yet verified this.

## Contributors

Kilian Koeltzsch, [@kiliankoe](https://github.com/kiliankoe)

## License

Pushover is available under the MIT license. See the LICENSE file for more info.
