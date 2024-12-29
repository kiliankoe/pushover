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
    ///   - completion: handler provided with a result value
    public func send(_ message: String, to user: String, completion: @escaping @Sendable (Result<Response, Error>) -> Void) {
        send(Notification(message: message, to: user), completion: completion)
    }

    /// Send a message directly to a user bypassing further customization options.
    ///
    /// - Parameters:
    ///   - message: message to be sent
    ///   - user: recipient
    ///
    /// - Returns: The response value
    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 13.0, *)
    @discardableResult
    public func send(_ message: String, to user: String) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            send(message, to: user) {
                continuation.resume(with: $0)
            }
        }
    }

    /// Send a `Notification` to Pushover.
    ///
    /// - Parameters:
    ///   - notification: notification to be sent
    ///   - completion: handler provided with a result value
    public func send(_ notification: Notification, completion: @escaping @Sendable (Result<Response, Error>) -> Void) {
        var request = URLRequest(url: Endpoint.messages)
        request.httpMethod = "POST"
        request.add(notification: notification, withToken: self.token)

        API.send(request) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success((headers, json)):
                guard let response = Response(fromJSON: json, andHeaders: headers) else { completion(.failure(.decoding)); return }
                completion(.success(response))
            }
        }
    }

    /// Send a `Notification` to Pushover.
    ///
    /// - Parameter notification: notification to be sent
    /// - Returns: The response value
    @available(macOS 10.15, iOS 13.0, macCatalyst 13.0, tvOS 13.0, watchOS 13.0, *)
    @discardableResult
    public func send(_ notification: Notification) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            send(notification) {
                continuation.resume(with: $0)
            }
        }
    }
}
