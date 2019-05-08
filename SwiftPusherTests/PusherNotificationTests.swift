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
    let token = "03df25c845d460bcdad7802d2vf6fc1dfde97283bf75cc993eb6dca835ea2e2f"
    let payload = """
                    {
                    "aps" : {
                        "alert" : {
                        "title" : "Game Request",
                        "subtitle" : "Five Card Draw"
                        "body" : "Bob wants to play poker",
                        },
                        "category" : "GAME_INVITATION"
                        },
                        "gameID" : "12345678"
                    }
                    """

    override func setUp() {
        notification = PusherNotification(withPayload: payload,
                                          token: token,
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

    func testHexFromData() {
        guard let data = "ffffff".data(using: .utf8) else {
            XCTFail("Can not create hex data!")
            return
        }
        let hex = notification.hexFromData(data)
        XCTAssertEqual(hex, "666666666666")
    }

    func testDataType0() {
        guard let tokenData = token.data(using: .utf8),
            let payloadData = payload.data(using: .utf8) else {
            XCTFail("Sample datas can not generated!")
            return
        }
        let dataType0 = notification.dataType0(withTokenData: tokenData, payloadData: payloadData)
        XCTAssertEqual(dataType0.count, tokenData.count + payloadData.count, "dataType0 failed to create a new data!")
    }

}
