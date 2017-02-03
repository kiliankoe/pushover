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

    init?(fromJSON json: JSON) {
        guard let status = json["status"] as? Int,
            let request = json["request"] as? String else {
                return nil
        }

        self.status = status
        self.request = request
        self.message = json["message"] as? String
        self.errors = json["errors"] as? [String]
    }
}
