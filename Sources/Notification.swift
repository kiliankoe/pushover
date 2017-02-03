//
//  Notification.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

public struct Notification {
    public var message: String
    public var users: [String]
    public var devices: [String]? = nil
    public var title: String? = nil
    public var url: String? = nil
    public var urlTitle: String? = nil
    public var timestamp: Date? = nil
    public var priority: Priority? = nil
    public var sound: Sound? = nil
    public var isHTML: Bool? = nil
    /// To be used with .emergency priority. How often to retry sending in seconds. Must be >=30.
    public var retryIn: UInt? = nil
    /// To be used with .emergency priority. When should retrying expire in seconds. Must be <=86400 (24 hours).
    public var expiresIn: UInt? = nil

    public init(message: String, to users: [String]) {
        self.message = message
        self.users = users
    }

    public init(message: String, to user: String) {
        self.init(message: message, to: [user])
    }

    var asParams: [String: String] {
        var params = [String: String]()

        params["message"] = message
        params["user"] = users.joined(separator: ",")
        if let devices = devices { params["device"] = devices.joined(separator: ",") }
        if let title = title { params["title"] = title }
        if let url = url { params["url"] = url }
        if let urlTitle = urlTitle { params["url_title"] = urlTitle }
        if let timestamp = timestamp { params["timestamp"] = "\(timestamp.timeIntervalSince1970)" }
        if let priority = priority { params["priority"] = "\(priority.rawValue)" }
        if let sound = sound { params["sound"] = sound.rawValue }
        if let isHTML = isHTML, isHTML { params["html"] = "1" }
        if let retryIn = retryIn { params["retry"] = "\(retryIn)" }
        if let expiresIn = expiresIn { params["expire"] = "\(expiresIn)" }

        return params
    }

    var paramsString: String {
        return asParams
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
