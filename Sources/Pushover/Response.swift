//
//  Response.swift
//  Pushover
//
//  Created by Kilian Költzsch on 03/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

/// A response from the Pushover API
public struct Response {
    let status: Int
    let request: String
    let message: String?
    /// Possible errors like wrong API or user keys.
    let errors: [String]?

    /// Your app's limit
    var limit: UInt? = nil
    /// Your app's remaining pushs for this time period.
    var remaining: UInt? = nil
    /// Timestamp when your app's remaining count will be reset.
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
