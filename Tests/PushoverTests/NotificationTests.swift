//
//  NotificationTests.swift
//  Pushover
//
//  Created by Kilian Költzsch on 03/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import XCTest
@testable import Pushover

class NotificationTests: XCTestCase {
    func testParamsAvailability() {
        var not = Notification(message: "foobar", to: "barbaz")
        XCTAssert(not.paramsString.contains("message=foobar"))
        XCTAssert(not.paramsString.contains("user=barbaz"))

        not.devices = ["device1", "device2"]
        XCTAssert(not.paramsString.contains("device=device1,device2"))

        not.title = "some title"
        XCTAssert(not.paramsString.contains("title=some%20title"))

        not.url = "http://example.com"
        XCTAssert(not.paramsString.contains("url=http://example.com"))

        not.urlTitle = "title for url"
        XCTAssert(not.paramsString.contains("url_title=title%20for%20url"))

        not.timestamp = Date(timeIntervalSince1970: 100)
        XCTAssert(not.paramsString.contains("timestamp=100"))

        not.priority = .high
        XCTAssert(not.paramsString.contains("priority=1"))

        not.sound = .intermission
        XCTAssert(not.paramsString.contains("sound=intermission"))

        not.isHTML = true
        XCTAssert(not.paramsString.contains("html=1"))

        not.retryIn = 60
        XCTAssert(not.paramsString.contains("retry=60"))

        not.expiresIn = 3600
        XCTAssert(not.paramsString.contains("expire=3600"))
    }

    func testAddingOnRequest() {
        let token = "token123"
        let not = Notification(message: "foobar", to: "barbaz")
        var req = URLRequest(url: URL(string: "http://example.com")!)

        req.add(notification: not, withToken: token)

        guard let body = req.httpBody else { XCTFail("no request body"); return }

        guard let bodyStr = String(data: body, encoding: .utf8) else { XCTFail("failed to decode request body"); return }

        XCTAssert(bodyStr.contains("token=token123"))
        XCTAssert(bodyStr.contains("message=foobar"))
        XCTAssert(bodyStr.contains("user=barbaz"))
    }
}

#if os(Linux)
    extension NotificationTests {
        static var allTests : [(String, (NotificationTests) -> () throws -> Void)] {
            return [
                ("testParamsAvailability", testParamsAvailability),
                ("testAddingOnRequest", testAddingOnRequest),
            ]
        }
    }
#endif
