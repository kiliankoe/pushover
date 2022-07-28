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
    static func send(_ request: URLRequest, completion: @escaping (Result<([String: String], JSON), Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error { completion(.failure(.network)); return }

            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { completion(.failure(.network)); return }
            guard let headers = (response as? HTTPURLResponse)?.allHeaderFields as? [String: String] else { completion(.failure(.network)); return }

            if case 500...599 = statusCode { completion(.failure(.server)); return }

            guard let data = data else { completion(.failure(.network)); return }

            guard let deserialized = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { completion(.failure(.decoding)); return }
            guard let json = deserialized as? JSON else { completion(.failure(.decoding)); return }

            completion(.success((headers, json)))
        }.resume()
    }
}
