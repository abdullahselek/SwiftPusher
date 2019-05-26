//
//  SSLConnection.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 18/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation
import CoreFoundation

internal class TCPClientCallBack {

    init(socket: CFSocket?,
         type: CFSocketCallBackType,
         address: CFData?,
         data: UnsafeRawPointer?,
         info: UnsafeMutableRawPointer?) {

    }
}

open class SSLConnection {

    /// The host name, which will be resolved using DNS.
    fileprivate let host: String
    /// The host TCP port number.
    fileprivate let port: Int
    /// Identity containing a certificate-key pair for setting up the TLS connection.
    fileprivate let identity: SecIdentity
    fileprivate let socket: Int
    fileprivate var context: SSLContext?

    init(withHost host: String,
         port: Int,
         identity: SecIdentity) {
        self.host = host
        self.port = port
        self.identity = identity
        self.socket = -1
    }

    func acceptConnection(socket: CFSocket?,
                          type: CFSocketCallBackType,
                          address: CFData?,
                          data: UnsafeRawPointer?,
                          info: UnsafeMutableRawPointer?) {
        // Accept connection and stuff later
    }

    open func connectSocket(withError error: inout Error?) -> Bool {
        let socket = CFSocketCreate(kCFAllocatorDefault,
                                    AF_INET,
                                    SOCK_STREAM,
                                    0,
                                    CFSocketCallBackType.readCallBack.rawValue,
                                    { socket, callBackType, address, data, info in
                                        guard let socket = socket,
                                            let address = address,
                                            let data = data,
                                            let info = info else {
                                            return
                                        }
                                        let mySelf = Unmanaged<SSLConnection>.fromOpaque(UnsafeRawPointer(info)).takeUnretainedValue()
                                        mySelf.acceptConnection(socket: socket, type: callBackType, address: address, data: data, info: info)
        }, nil)
        if socket == nil {
            return PusherError.no(withCode: .socketCreate, error: &error)
        }

        var address = sockaddr_in()
        memset(&address, 0, MemoryLayout<sockaddr_in>.size)
        var hostinfo: UnsafeMutablePointer<hostent>

        return true
    }
}
