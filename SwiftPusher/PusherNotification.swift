//
//  Notification.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 03/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation

enum Size {
    static let DeviceToken = 32
    static let PayloadMax = 256
}

public struct PusherNotification {

    /// String representation of serialized JSON.
    var payload: String?

    /// UTF-8 data representation of serialized JSON.
    var payloadData: Data?

    /// Hex string representation of the device token.
    var token: String?

    /// Data representation of the device token.
    var tokenData: Data?

    /// Identifier used for correlating server response on error.
    var identifier: Int?

    /// The expiration date after which the server will not attempt to deliver.
    var expiration: Date?

    /// Epoch seconds representation of expiration date.
    var expirationStamp: Int?

    /// Notification priority used by server for delivery optimization.
    var priority: Int?

    /// Indicates whether the expiration date should be serialized.
    var addExpiration: Bool?

    /// Create and returns a notification object based on given attribute objects.
    public init(withPayload payload: String,
                token: String,
                identifier: Int,
                expiration: Date,
                priority: Int) {
        self.payload = payload
        self.token = token
        self.identifier = identifier
        self.expiration = expiration
        self.priority = priority
    }

    /// Create and returns a notification object based on given raw attributes.
    public init(withPayloadData data: Data,
                tokenData: Data,
                identifier: Int,
                expirationStamp: Int,
                addExpiration: Bool,
                priority: Int) {
        self.payloadData = data
        self.tokenData = tokenData
        self.identifier = identifier
        self.expirationStamp = expirationStamp
        self.addExpiration = addExpiration
        self.priority = priority
    }

    // MARK: Helpers

    internal func filterHex(_ hex: String) -> String {
        let hex = hex.lowercased()
        var result = ""
        for (_, c) in hex.enumerated() {
            if (c >= "a" && c <= "f") || (c >= "0" && c <= "9") {
                result = result + String(c)
            }
        }
        return result
    }

    internal func dataFromHex(_ hex: String) -> Data? {
        var result = Data()
        for (index, _) in hex.enumerated() {
            if index < hex.count / 2 {
                var buffer = [Character]()
                buffer.append(hex[index * 2])
                buffer.append(hex[index * 2 + 1])
                let hexa = String(buffer).hexaToDecimal
                result.append(UInt8(hexa))
            }
        }
        return result
    }

    internal func hexFromData(_ data: Data) -> String {
        return data.reduce("") {
            $0 + String(format: "%02x", $1)
        }
    }

    internal func dataType0() -> Data {
        guard let tokenData = self.tokenData,
            let payloadData = payloadData else {
                print("SwiftPusher: missing values to generate data with type0!")
                return Data()
        }
        var result = tokenData
        result.append(payloadData)
        return result
    }

    internal func dataType1() -> Data {
        guard var identifier = self.identifier,
            var expirationStamp = self.expirationStamp,
            let tokenData = self.tokenData,
            let payloadData = payloadData else {
                print("SwiftPusher: missing values to generate data with type1!")
                return Data()
        }
        let identifierData = Data(bytes: &identifier,
                                  count: MemoryLayout.size(ofValue: identifier))
        var result = identifierData
        let expirationStampData = Data(bytes: &expirationStamp,
                                       count: MemoryLayout.size(ofValue: expirationStamp))
        result.append(expirationStampData)
        result.append(tokenData)
        result.append(payloadData)
        return result
    }

}
