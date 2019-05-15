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
    var payload: String? {
        get {
            if let payloadData = payloadData {
                return String(data: payloadData, encoding: .utf8)
            }
            return nil
        }
        set {
            payloadData = newValue?.data(using: .utf8)
        }
    }

    /// UTF-8 data representation of serialized JSON.
    var payloadData: Data?

    /// Hex string representation of the device token.
    var token: String? {
        get {
            if let tokenData = tokenData {
                return hexFromData(tokenData)
            }
            return nil
        }
        set {
            if let token = newValue {
                let normal = filterHex(token)
                if normal.count >= 64 {
                    let index: String.Index = normal.index(normal.startIndex, offsetBy: 64)
                    let trunk = normal[..<index]
                    tokenData = dataFromHex(String(trunk))
                }
            } else {
                tokenData = nil
            }
        }
    }

    /// Data representation of the device token.
    var tokenData: Data?

    /// Identifier used for correlating server response on error.
    var identifier: Int?

    /// The expiration date after which the server will not attempt to deliver.
    var expiration: Date? {
        get {
            return addExpiration ? Date.init(timeIntervalSince1970: TimeInterval(expirationStamp ?? 0)) : nil
        }
        set {
            expirationStamp = Int(newValue?.timeIntervalSince1970 ?? 0)
            addExpiration = newValue != nil ? true : false
        }
    }

    /// Epoch seconds representation of expiration date.
    var expirationStamp: Int?

    /// Notification priority used by server for delivery optimization.
    var priority: Int?

    /// Indicates whether the expiration date should be serialized.
    var addExpiration: Bool!

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

    internal func dataType2() -> Data {
        var result = NSMutableData()
        if let data = tokenData {
            var identifier = 1
            appendTo(data: &result,
                     identifier: &identifier,
                     bytes: data,
                     length: data.count)
        }
        if let payloadData = payloadData {
            var identifier = 2
            appendTo(data: &result,
                     identifier: &identifier,
                     bytes: payloadData,
                     length: payloadData.count)
        }
        var id = UInt32(0)
        if let i = identifier {
            let i32 = UInt32(i)
            id = CFSwapInt32(i32)
        }
        var expires = UInt32(0)
        if let ex = expirationStamp {
            let ex32 = UInt32(ex)
            expires = CFSwapInt32(ex32)
        }
        var priority = UInt8(0)
        if let p = self.priority {
            priority = UInt8(p)
        }
        var iden = 3
        let identifierData = Data(bytes: &id,
                                  count: MemoryLayout.size(ofValue: id))
        appendTo(data: &result,
                 identifier: &iden,
                 bytes: identifierData,
                 length: 4)
        if let addExpiration = self.addExpiration, addExpiration == true {
            var identifier = 4
            let expires = Data(bytes: &expires,
                               count: MemoryLayout.size(ofValue: expires))
            appendTo(data: &result,
                     identifier: &identifier,
                     bytes: expires,
                     length: 4)
        }
        var identifier = 5
        let priorityData = Data(bytes: &priority,
                                count: MemoryLayout.size(ofValue: priority))
        appendTo(data: &result,
                 identifier: &identifier,
                 bytes: priorityData,
                 length: 1)
        var command = UInt8(2)
        result.replaceBytes(in: NSRange(location: 0, length: 1), withBytes: &command)
        var length = CFSwapInt32(UInt32(result.count - 5))
        result.replaceBytes(in: NSRange(location: 1, length: 4), withBytes: &length)
        return Data(referencing: result)
    }

    private func appendTo(data: inout NSMutableData,
                          identifier: inout Int,
                          bytes: Data,
                          length: Int) {
        data.append(&identifier, length: 1)
        var length = CFSwapInt16(UInt16(length))
        data.append(&length, length: 2)
        bytes.withUnsafeBytes { rawBufferPointer in
            let rawPtr = rawBufferPointer.baseAddress!
            data.append(rawPtr, length: bytes.count)
        }
    }

}
