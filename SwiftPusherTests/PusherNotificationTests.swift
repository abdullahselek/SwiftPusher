//
//  NotificationTests.swift
//  SwiftPusherTests
//
//  Created by Abdullah Selek on 03/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftPusher;

class PusherNotificationTests: XCTestCase {

    var notification: PusherNotification!

    override func setUp() {
        notification = PusherNotification(withPayload: "payload",
                                          token: "token",
                                          identifier: 1,
                                          expiration: Date(timeIntervalSince1970: TimeInterval(1000) / 1000),
                                          priority: 1)
    }

    override func tearDown() {
        notification = nil
    }

    func testPusherNotificationInit() {
        XCTAssertNotNil(notification, "PusherNotification can not initiated!")
    }

}
