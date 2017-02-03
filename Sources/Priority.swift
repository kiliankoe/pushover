//
//  Priority.swift
//  Pushover
//
//  Created by Kilian Költzsch on 03/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

/// Custom priority values.
///
/// See here for more details: https://pushover.net/api#priority
public enum Priority: Int {
    case noAlert = -2
    case quiet
    case normal
    case high
    case emergency
}
