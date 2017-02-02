//
//  Error.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

public enum Error: Swift.Error {
    case invalidRequest(message: String)
    case serverError
}
