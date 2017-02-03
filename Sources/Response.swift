//
//  Response.swift
//  Pushover
//
//  Created by Kilian Költzsch on 03/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

public struct Response {
    let status: Int
    let request: String
    let message: String?
    let errors: [String]?

    var limit: UInt? = nil
    var remaining: UInt? = nil
    var reset: Date? = nil

    init?(fromJSON json: JSON, andHeaders headers: [String: String]) {
        guard let status = json["status"] as? Int,
            let request = json["request"] as? String else {
                return nil
        }

        self.status = status
        self.request = request
        self.message = json["message"] as? String
        self.errors = json["errors"] as? [String]

        if let limit = headers["X-Limit-App-Limit"] { self.limit = UInt(limit) ?? 0 }
        if let remaining = headers["X-Limit-App-Remaining"] { self.remaining = UInt(remaining) ?? 0 }
        if let reset = headers["X-Limit-App-Reset"] { self.reset = Date(timeIntervalSince1970: Double(reset) ?? 0) }
    }
}
