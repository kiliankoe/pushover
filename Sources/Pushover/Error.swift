//
//  Error.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

/// Possible error case that can be encountered.
///
/// - server: Something unexpected went wrong on the server side.
/// - network: Sending of the request failed.
/// - decoding: The received data could not be decoded.
public enum Error: Swift.Error {
    case server
    case network
    case decoding
}
