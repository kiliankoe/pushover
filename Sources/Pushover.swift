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

    public func send(_ notification: Notification, onFailure fail: ((Error) -> Void)? = nil, onSuccess succeed: (() -> Void)? = nil) {
        var request = URLRequest(url: Endpoint.messages)
        request.httpMethod = "POST"
        request.add(notification: notification)

        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response!)
            print(data!)

            succeed?()
        }.resume()
    }
}
