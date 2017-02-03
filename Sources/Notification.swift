//
//  Notification.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

public struct Notification {
    public let message: String
    public let users: [String]
    public let devices: [String]? = nil
    public let title: String? = nil
    public let url: String? = nil
    public let urlTitle: String? = nil
    public let timestamp: Date? = nil
    public let priority: Priority = .normal
    public let sound: Sound? = nil
    public let isHTML: Bool? = nil

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
        params["priority"] = "\(priority.rawValue)"
        if let sound = sound { params["sound"] = sound.rawValue }
        if let isHTML = isHTML, isHTML { params["html"] = "1" }

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
    mutating func add(notification: Notification) {
        self.httpBody = notification.paramsString.data(using: .utf8)
    }
}

extension String {
    var urlEscaped: String {
        // this is sooo verbose >.<
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
}
