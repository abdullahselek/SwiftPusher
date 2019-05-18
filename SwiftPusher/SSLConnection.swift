//
//  SSLConnection.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 18/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation

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

}
