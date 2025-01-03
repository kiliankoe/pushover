//
//  API.swift
//  Pushover
//
//  Created by Kilian Költzsch on 02/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

typealias JSON = [String: Any]

enum API {
    static func send(_ request: URLRequest) async throws(PushoverError) -> ([String: String], JSON) {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse,
                  let headers = httpResponse.allHeaderFields as? [String: String]
            else {
                throw PushoverError.network
            }

            if case 500...599 = httpResponse.statusCode {
                throw PushoverError.server
            }

            guard let deserialized = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? JSON else {
                throw PushoverError.decoding
            }
            return (headers, deserialized)
        } catch {
            throw PushoverError.network
        }
    }
}
