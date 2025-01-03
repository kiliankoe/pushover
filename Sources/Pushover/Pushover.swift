//
//  Pushover.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Pushover API client which is used for all communication with the Pushover.net service.
public struct Pushover: Sendable {
    let token: String

    public init(token: String) {
        self.token = token
    }

    /// Send a message directly to a user bypassing further customization options.
    ///
    /// - Parameters:
    ///   - message: message to be sent
    ///   - user: recipient
    ///
    /// - Throws: An ``Error`` case.
    /// - Returns: The ``Response`` value.
    @discardableResult
    public func send(_ message: String, to user: String) async throws(PushoverError) -> Response {
        try await send(Notification(message: message, to: user))
    }

    /// Send a `Notification` to Pushover.
    ///
    /// - Parameter notification: notification to be sent
    /// - Throws: An ``Error`` case.
    /// - Returns: The ``Response`` value.
    @discardableResult
    public func send(_ notification: Notification) async throws(PushoverError) -> Response {
        var request = URLRequest(url: Endpoint.messages)
        request.httpMethod = "POST"
        request.add(notification: notification, withToken: self.token)

        let (headers, json) = try await API.send(request)
        guard let response = Response(fromJSON: json, andHeaders: headers) else {
            throw PushoverError.decoding
        }
        return response
    }
}
