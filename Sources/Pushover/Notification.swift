//
//  Notification.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// A notification to be sent to some devices
public class Notification {

    /// Collection of custom parameters for this notification
    public var params = [String: String]()

    /// Create a new notification.
    ///
    /// - Parameters:
    ///   - message: message to be sent
    ///   - users: recipients
    public init(message: String, to users: [String]) {
        self.params["message"] = message
        self.params["user"] = users.joined(separator: ",")
    }

    /// Create a new notification.
    ///
    /// - Parameters:
    ///   - message: message to be sent
    ///   - users: recipients
    public convenience init(message: String, to users: String...) {
        self.init(message: message, to: users)
    }

    /// Send a notification only to specified device names.
    ///
    /// - Parameter devices: devices
    public func devices(_ devices: [String]) -> Notification {
        self.params["device"] = devices.joined(separator: ",")
        return self
    }

    /// Set a custom title, otherwise the app name is used.
    ///
    /// - Parameter title: title
    public func title(_ title: String) -> Notification {
        self.params["title"] = title
        return self
    }

    /// Attach a URL. Note that URLs included in the message are already clickable in
    /// the Pushover applications.
    ///
    /// - Parameter url: url
    public func url(_ url: String) -> Notification {
        self.params["url"] = url
        return self
    }

    /// Set a custom title for an attached URL.
    ///
    /// - Parameter urlTitle: url title
    public func urlTitle(_ urlTitle: String) -> Notification {
        self.params["url_title"] = urlTitle
        return self
    }

    /// Set a time to be displayed as the sent time.
    ///
    /// - Parameter timestamp: timestamp
    public func timestamp(_ timestamp: Date) -> Notification {
        self.params["timestamp"] = "\(timestamp.timeIntervalSince1970)"
        return self
    }

    /// Set a custom priority. See `Priority` for more details.
    ///
    /// - Parameter priority: priortiy
    public func priority(_ priority: Priority) -> Notification {
        self.params["priority"] = "\(priority.rawValue)"
        return self
    }

    /// Set a custom sound for this notification. See `Sound` for more details.
    ///
    /// - Parameter sound: sound
    public func sound(_ sound: Sound) -> Notification {
        self.params["sound"] = sound.rawValue
        return self
    }

    /// Specify if the message contains HTML, which will be displayed correctly by
    /// the Pushover applications.
    ///
    /// - Parameter isHTML: is HTML?
    public func isHTML(_ isHTML: Bool) -> Notification {
        self.params["html"] = isHTML ? "1" : "0"
        return self
    }

    /// To be used with .emergency priority. How often to retry sending in seconds. Must be >=30.
    ///
    /// - Parameter seconds: seconds
    public func retry(in seconds: UInt) -> Notification {
        self.params["retry"] = "\(seconds)"
        return self
    }

    /// To be used with .emergency priority. When should retrying expire in seconds. Must be <=86400 (24 hours).
    ///
    /// - Parameter seconds: seconds
    public func expires(in seconds: UInt) -> Notification {
        self.params["expire"] = "\(seconds)"
        return self
    }

    internal var paramsString: String {
        return params
            .map { "\($0.key.urlQueryEscaped)=\($0.value.urlQueryEscaped)" }
            .joined(separator: "&")
    }
}

extension URLRequest {
    mutating func add(notification: Notification, withToken token: String) {
        let params = "token=\(token)&\(notification.paramsString)"
        self.httpBody = params.data(using: .utf8)
    }
}

extension String {
    var urlQueryEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
