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

    func testInitPusherNotification() {
        XCTAssertNotNil(notification, "PusherNotification can not initiated!")
    }

    func testInitPusherNotificationWithData() {
        guard let data = "data".data(using: .utf8), let token = "token".data(using: .utf8) else {
            XCTFail("Can not generate data parameters!")
            return
        }
        let notification = PusherNotification(withPayloadData: data,
                                              tokenData: token,
                                              identifier: 1,
                                              expirationStamp: 10,
                                              addExpiration: true,
                                              priority: 1)
        XCTAssertNotNil(notification, "PusherNotification can not initiated with data!")
    }

    func testFilterHex() {
        var result = notification.filterHex("255")
        XCTAssertEqual(result, "255")
        result = notification.filterHex("ff")
        XCTAssertEqual(result, "ff")
    }

    func testDataFromHex() {
        let data1 = notification.dataFromHex("ffffff")
        XCTAssertNotNil(data1, "Can not get data1 from hex!")
        let data2 = notification.dataFromHex("aaaaaa")
        XCTAssertNotNil(data2, "Can not get data2 from hex!")
        XCTAssertNotEqual(data1, data2)
    }

}
