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

class PushoverTests: XCTestCase {
    func testSimpleSend() {
        let e = expectation(description: "Send basic notification")

        Pushover(token: EXAMPLE_TOKEN).send("Hello from Swift", to: "", onFailure: { error in
            print(error)
            e.fulfill()
        }) { response in
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
