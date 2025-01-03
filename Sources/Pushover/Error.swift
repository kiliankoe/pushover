//
//  Error.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

/// Possible error case that can be encountered.
public enum Error: Swift.Error {
    /// Something unexpected went wrong on the server side.
    case server

    /// Sending of the request failed.
    case network

    /// The received data could not be decoded.
    case decoding
}
