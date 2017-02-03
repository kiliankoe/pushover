//
//  Pushover.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

public struct Pushover {
    let token: String

    public init(token: String) {
        self.token = token
    }

    public func send(_ message: String, to user: String, completion: @escaping (Result<Response, Error>) -> Void) {
        send(Notification(message: message, to: user), completion: completion)
    }

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
}
