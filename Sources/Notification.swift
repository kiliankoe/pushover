//
//  Notification.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

public struct Notification {

    public var params = [String: String]()

    public init(message: String, to users: [String]) {
        self.params["message"] = message
        self.params["user"] = users.joined(separator: ",")
    }

    public init(message: String, to user: String) {
        self.init(message: message, to: [user])
    }

    public mutating func devices(_ devices: [String]) {
        self.params["device"] = devices.joined(separator: ",")
    }

    public mutating func title(_ title: String) {
        self.params["title"] = title
    }

    public mutating func url(_ url: String) {
        self.params["url"] = url
    }

    public mutating func urlTitle(_ urlTitle: String) {
        self.params["url_title"] = urlTitle
    }

    public mutating func timestamp(_ timestamp: Date) {
        self.params["timestamp"] = "\(timestamp.timeIntervalSince1970)"
    }

    public mutating func priority(_ priority: Priority) {
        self.params["priority"] = "\(priority.rawValue)"
    }

    public mutating func sound(_ sound: Sound) {
        self.params["sound"] = sound.rawValue
    }

    public mutating func isHTML(_ isHTML: Bool) {
        self.params["html"] = isHTML ? "1" : "0"
    }

    /// To be used with .emergency priority. How often to retry sending in seconds. Must be >=30.
    public mutating func retry(in seconds: UInt) {
        self.params["retry"] = "\(seconds)"
    }

    /// To be used with .emergency priority. When should retrying expire in seconds. Must be <=86400 (24 hours).
    public mutating func expires(in seconds: UInt) {
        self.params["expire"] = "\(seconds)"
    }

    var paramsString: String {
        return params
            .map { "\($0.key.urlEscaped)=\($0.value.urlEscaped)" }
            .joined(separator: "&")
    }
}

public enum Priority: Int {
    case noAlert = -2
    case quiet
    case normal
    case high
    case emergency
}

extension URLRequest {
    mutating func add(notification: Notification, withToken token: String) {
        let params = "token=\(token)&\(notification.paramsString)"
        self.httpBody = params.data(using: .utf8)
    }
}

extension String {
    var urlEscaped: String {
        // this is sooo verbose >.<
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
