//
//  Endpoint.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

enum Endpoint {
    static let apiBaseV1 = URL(string: "https://api.pushover.net/1/")!

    static let messages = URL(string: "messages.json", relativeTo: Endpoint.apiBaseV1)!
    static let validate = URL(string: "validate.json", relativeTo: Endpoint.apiBaseV1)!
}
