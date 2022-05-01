//
//  Pushover.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import Dispatch
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Pushover API client which is used for all communication with the Pushover.net service.
public struct Pushover {
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
    public func send(_ message: String, to user: String, completion: @escaping (Result<Response, Error>) -> Void) {
        send(Notification(message: message, to: user), completion: completion)
    }

    /// Send a `Notification` to Pushover.
    ///
    /// - Parameters:
    ///   - notification: notification to be sent
    ///   - completion: handler provided with a result value
    public func send(_ notification: Notification, completion: @escaping (Result<Response, Error>) -> Void) {
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


    /// Send a `Notification` synchronously.
    ///
    /// - Parameter notification: notification to be sent
    /// - Returns: result value
    @discardableResult public func sendSynchronously(_ notification: Notification) -> Result<Response, Error> {
        let sema = DispatchSemaphore(value: 0)
        var result: Result<Response, Error>! = nil

        self.send(notification) { res in
            result = res
            sema.signal()
        }

        sema.wait()
        return result
    }
}
