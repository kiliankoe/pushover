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
        let not = Notification(message: "foobar", to: "bar", "baz")
            .devices(["device1", "device2"])
            .title("some title")
            .url("http://example.com")
            .urlTitle("title for url")
            .timestamp(Date(timeIntervalSince1970: 100))
            .priority(.high)
            .sound(.intermission)
            .isHTML(true)
            .retry(in: 60)
            .expires(in: 3600)

        XCTAssert(not.paramsString.contains("message=foobar"))
        XCTAssert(not.paramsString.contains("user=bar,baz"))
        XCTAssert(not.paramsString.contains("device=device1,device2"))
        XCTAssert(not.paramsString.contains("title=some%20title"))
        XCTAssert(not.paramsString.contains("url=http://example.com"))
        XCTAssert(not.paramsString.contains("url_title=title%20for%20url"))
        XCTAssert(not.paramsString.contains("timestamp=100"))
        XCTAssert(not.paramsString.contains("priority=1"))
        XCTAssert(not.paramsString.contains("sound=intermission"))
        XCTAssert(not.paramsString.contains("html=1"))
        XCTAssert(not.paramsString.contains("retry=60"))
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

    static var allTests = [
        ("testParamsAvailability", testParamsAvailability),
        ("testAddingOnRequest", testAddingOnRequest),
    ]
}
