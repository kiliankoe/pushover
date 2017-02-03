import XCTest
@testable import PushoverTests

XCTMain([
    testCase(PushoverTests.allTests),
    testCase(NotificationTests.allTests),
])
