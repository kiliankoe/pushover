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

    public func send(_ message: String, to user: String, onFailure fail: ((Error) -> Void)? = nil, onSuccess succeed: ((Response) -> Void)? = nil) {
        let notification = Notification(message: message, to: user)
        send(notification, onFailure: fail, onSuccess: succeed)
    }

    public func send(_ notification: Notification, onFailure fail: ((Error) -> Void)? = nil, onSuccess succeed: ((Response) -> Void)? = nil) {
        var request = URLRequest(url: Endpoint.messages)
        request.httpMethod = "POST"
        request.add(notification: notification, withToken: self.token)

        API.send(request, onFailure: fail) { (statusCode, headers, json) in
            if case 400...499 = statusCode {
                let errors = json["errors"] as? [String] ?? []
                fail?(.invalidRequest(errors: errors))
                return
            }

            guard let response = Response(fromJSON: json, andHeaders: headers) else { fail?(.decoding); return }

            succeed?(response)
        }
    }
}
