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

    public func send(notification: Notification, _ completion: @escaping () -> Void) {
        var request = URLRequest(url: Endpoint.messages)
        request.add(notification: notification)

        URLSession.shared.dataTask(with: request) { data, response, error in
            print(response!)
            print(data!)

            completion()
        }.resume()
    }
}
