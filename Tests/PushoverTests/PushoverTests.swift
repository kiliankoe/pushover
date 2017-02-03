//
//  PushoverTests.swift
//  Pushover
//
//  Created by Kilian Költzsch on 01/02/2017.
//  Copyright © 2017 Kilian Koeltzsch. All rights reserved.
//

import Foundation
import XCTest
import Pushover

let EXAMPLE_TOKEN = "azGDORePK8gMaC0QOYAMyEEuzJnyUi"
let EXAMPLE_USER = "poQWCJ812NgmER0QrTDF8D3Lnsd02L"

class PushoverTests: XCTestCase {
    func testSimpleSend() {
        let e = expectation(description: "Send basic notification")

        Pushover(token: EXAMPLE_TOKEN).send("Hello from Swift", to: EXAMPLE_USER) { result in
            e.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }

    func testAdvancedNotification() {
        let e = expectation(description: "Send advanced notification")

        var notification = Notification(message: "Hello from Swift", to: EXAMPLE_USER)
        notification.title("foobar")
        notification.devices(["iphone"])
        notification.priority(.high)
        notification.sound(.classical)
        notification.timestamp(Date())

        Pushover(token: EXAMPLE_TOKEN).send(notification) { result in
            e.fulfill()
        }

        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("\(error)")
            }
        }
    }
}

#if os(Linux)
extension PushoverTests {
    static var allTests : [(String, (PushoverTests) -> () throws -> Void)] {
        return [
            ("testSimpleSend", testSimpleSend),
        ]
    }
}
#endif
