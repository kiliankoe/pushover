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

    let limit: UInt
    let remaining: UInt
    let reset: Date

    init?(fromJSON json: JSON, andHeaders headers: [String: String]) {
        guard let status = json["status"] as? Int,
            let request = json["request"] as? String else {
                return nil
        }

        self.status = status
        self.request = request
        self.message = json["message"] as? String
        self.errors = json["errors"] as? [String]

        guard let limit = headers["X-Limit-App-Limit"],
            let remaining = headers["X-Limit-App-Remaining"],
            let reset = headers["X-Limit-App-Reset"] else {
                return nil
        }

        self.limit = UInt(limit) ?? 0
        self.remaining = UInt(remaining) ?? 0
        self.reset = Date(timeIntervalSince1970: Double(reset) ?? 0)
    }
}
