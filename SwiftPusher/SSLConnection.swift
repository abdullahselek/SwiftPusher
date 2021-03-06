//
//  SSLConnection.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 18/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation
import Network

open class SSLConnection {

    fileprivate var connection: NWConnection?
    /// The host name, which will be resolved using DNS.
    fileprivate let host: String
    /// The host TCP port number.
    fileprivate let port: Int
    /// Identity containing a certificate-key pair for setting up the TLS connection.
    fileprivate let identity: SecIdentity
    fileprivate var context: SSLContext?
    fileprivate var status: String!

    init(withHost host: String,
         port: Int,
         identity: SecIdentity) {
        self.host = host
        self.port = port
        self.identity = identity
    }

    func start() {
        let options = NWProtocolTLS.Options()
        let securityOptions = options.securityProtocolOptions
        let params = NWParameters(tls: options)
        let connection = NWConnection(host: NWEndpoint.Host(host),
                                      port: NWEndpoint.Port(integerLiteral: NWEndpoint.Port.IntegerLiteralType(port)),
                                      using: params)
        sec_protocol_options_set_verify_block(securityOptions, { _, trust, completionHandler in
            // let isTrusted = ...
            completionHandler(sec_identity_create(self.identity) != nil)
        }, .main)
        sec_protocol_options_set_local_identity(
            securityOptions,
            sec_identity_create(identity)!
        )
        connection.stateUpdateHandler = stateDidChange(to:)
        self.setupReceive(on: connection)
        connection.start(queue: .main)
        self.connection = connection
    }

    func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .setup:
            break
        case .waiting(let error):
            self.connectionDidFail(error: error)
        case .preparing:
            break
        case .ready:
            self.status = "Connected"
        case .failed(let error):
            self.connectionDidFail(error: error)
        case .cancelled:
            break
        @unknown default:
            fatalError()
        }
    }

    func connectionDidFail(error: Error) {

    }

    func setupReceive(on connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { data, contentContext, isComplete, error in
            if let data = data, !data.isEmpty {
                // … process the data …
                self.status = "did receive \(data.count) bytes"
            }
            if isComplete {
                // … handle end of stream …
//                self.stop(status: "EOF")
            } else if let error = error {
                // … handle error …
                self.connectionDidFail(error: error)
            } else {
                self.setupReceive(on: connection)
            }
        }
    }

    func sendStreamOriented(connection: NWConnection, data: Data) {
        connection.send(content: data, completion: .contentProcessed { error in
            if let error = error {
                self.connectionDidFail(error: error)
            }
        })
    }

    func sendEndOfStream(connection: NWConnection) {
        connection.send(content: nil, contentContext: .defaultStream, isComplete: true, completion: .contentProcessed { error in
            if let error = error {
                self.connectionDidFail(error: error)
            }
        })
    }

//    func acceptConnection(socket: CFSocket?,
//                          type: CFSocketCallBackType,
//                          address: CFData?,
//                          data: UnsafeRawPointer?,
//                          info: UnsafeMutableRawPointer?) {
//        // Accept connection and stuff later
//    }
//
//    open func connectSocket(withError error: inout Error?) -> Bool {
//        let socket = CFSocketCreate(kCFAllocatorDefault,
//                                    AF_INET,
//                                    SOCK_STREAM,
//                                    0,
//                                    CFSocketCallBackType.readCallBack.rawValue,
//                                    { socket, callBackType, address, data, info in
//                                        guard let socket = socket,
//                                            let address = address,
//                                            let data = data,
//                                            let info = info else {
//                                            return
//                                        }
//                                        let mySelf = Unmanaged<SSLConnection>.fromOpaque(UnsafeRawPointer(info)).takeUnretainedValue()
//                                        mySelf.acceptConnection(socket: socket, type: callBackType, address: address, data: data, info: info)
//        }, nil)
//        if socket == nil {
//            return PusherError.no(withCode: .socketCreate, error: &error)
//        }
//
//        var address = sockaddr_in()
//        memset(&address, 0, MemoryLayout<sockaddr_in>.size)
//        let entr = gethostname(UnsafeMutablePointer<Int8>(mutating: (host as NSString).utf8String), MemoryLayout.size(ofValue: host))
//        if entr == 0 {
//            return PusherError.no(withCode: .socketResolveHostName, error: &error)
//        }
//        var host: in_addr!
//        memcpy(&host, UnsafeRawPointer(bitPattern: Int(entr)), MemoryLayout.size(ofValue: host))
//        address.sin_addr = host
//        address.sin_port = CFSwapInt16(UInt16(port))
//        address.sin_family = sa_family_t(AF_INET)
//
//        return true
//    }
}
