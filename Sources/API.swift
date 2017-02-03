//
//  API.swift
//  Pushover
//
//  Created by Kilian Költzsch on 02/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

enum API {
    static func send(_ request: URLRequest, onFailure fail: ((Error) -> Void)?, onSuccess succeed: ((Int, [String: String], JSON) -> Void)?) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error { fail?(.network); return }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { fail?(.network); return }
            guard let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: String] else { fail?(.network); return }

            if case 500...599 = statusCode { fail?(.server); return }

            guard let data = data else { fail?(.network); return }

            guard let deserialized = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { fail?(.decoding); return }
            guard let json = deserialized as? JSON else { fail?(.decoding); return }

            succeed?(statusCode, headers, json)
        }.resume()
    }
}
