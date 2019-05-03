//
//  Types.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 03/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation

/// The current and past data formats supported by APNs. For more information see Apple documentation under 'Legacy Information'.
enum NotificationType {
    /// The 'Simple Notification Format'. The oldest format simply concatenates the device token and payload.
    case simple
    /// The 'Enhanced Notification Format'. Similar to the previous format but includes and identifier and expiration date.
    case enchanced
    /// The 'Binary Interface and Notification Format'. The latest more extensible format that allows for attributes like priority.
    case binary
}

/// Types of push certificates.
enum CertType {
    /// None.
    case none
    /// iOS Development.
    case iosDev
    /// iOS Production.
    case iosProduction
    /// OS X Development.
    case macDevelopment
    /// OS X Production.
    case macProduction
    /// Simplified Certificate Handling.
    case simplified
    /// Web Push Production.
    case webProduction
    /// VoIP Services.
    case voIPServices
    /// WatchKit Services.
    case watchKitServices
    /// Pass Type ID.
    case passes
    /// Unknown.
    case unknown
}

/// List all error codes.
enum Error: Int {
    /// No error that's odd.
    case none = 0

    /// APN processing error.
    case apnProcessing = -1
    /// APN missing device token.
    case apnMissingDeviceToken = -2
    /// APN missing topic.
    case apnMissingTopic = -3
    /// APN missing payload.
    case apnMissingPayload = -4
    /// APN invalid token size.
    case apnInvalidTokenSize = -5
    /// APN invalid topic size.
    case apnInvalidTopicSize = -6
    /// APN invalid payload size.
    case apnInvalidPayloadSize = -7
    /// APN invalid token.
    case apnInvalidTokenContent = -8
    /// APN unknown reason.
    case apnUnknownReason = -9
    /// APN shutdown.
    case apnShutdown = -10
    /// APN unknown error code.
    case apnUnknownErrorCode = -11

    /// Push response command unknown.
    case pushResponseCommand = -107
    /// Push reconnect requires connection.
    case pushNotConnected = -111
    /// Push not fully sent.
    case pushWriteFail = -112

    /// Feedback data length unexpected.
    case feedbackLength = -108
    /// Feedback token length unexpected.
    case feedbackTokenLength = -109

    /// Socket cannot be created.
    case socketCreate = -222
    /// Socket connecting failed.
    case socketConnect = -201
    /// Socket host cannot be resolved.
    case socketResolveHostName = -219
    /// Socket file control failed.
    case socketFileControl = -220
    /// Socket options cannot be set.
    case socketOptions = -221

    /// SSL connection cannot be set.
    case sslConnection = -204
    /// SSL context cannot be created.
    case sslContext = -202
    /// SSL callbacks cannot be set.
    case sslIOFuncs = -203
    /// SSL peer domain name cannot be set.
    case sslPeerDomainName = -205
    /// SSL certificate cannot be set.
    case sslCertificate = -206
    /// SSL handshake dropped by server.
    case sslDroppedByServer = -207
    /// SSL handshake authentication failed.
    case sslAuthFailed = -208
    /// SSL handshake failed.
    case sslHandshakeFail = -209
    /// SSL handshake root not a known anchor.
    case sslHandshakeUnknownRootCert = -223
    /// SSL handshake chain not verifiable to root.
    case sslHandshakeNoRootCert = -224
    /// SSL handshake expired certificates.
    case sslHandshakeCertExpired = -225
    /// SSL handshake invalid certificate chain.
    case sslHandshakeXCertChainInvalid = -226
    /// SSL handshake expecting client cert.
    case sslHandshakeClientCertRequested = -227
    /// SSL handshake auth interrupted.
    case sslHandshakeServerAuthCompleted = -228
    /// SSL handshake certificate expired.
    case sslHandshakePeerCertExpired = -229
    /// SSL handshake certificate revoked.
    case sslHandshakePeerCertRevoked = -230
    /// SSL handshake certificate unknown.
    case sslHandshakePeerCertUnknown = -233
    /// SSL handshake internal error.
    case sslHandshakeInternalError = -234
    /// SSL handshake in dark wake.
    case sslInDarkWake = -231
    /// SSL handshake connection closed via error.
    case sslHandshakeClosedAbort = -232
    /// SSL handshake timeout.
    case sslHandshakeTimeout = -218

    /// Read connection dropped by server.
    case readDroppedByServer = -210
    /// Read connection error.
    case readClosedAbort = -211
    /// Read connection closed.
    case readClosedGraceful = -212
    /// Read failed.
    case readFail = -213

    /// Write connection dropped by server.
    case writeDroppedByServer = -214
    /// Write connection error.
    case writeClosedAbort = -215
    /// Write connection closed.
    case writeClosedGraceful = -216
    /// Write failed.
    case writeFail = -217

    /// Identity does not contain certificate.
    case identityCopyCertificate = -304
    /// Identity does not contain private key.
    case identityCopyPrivateKey = -310

    /// PKCS12 data cannot be imported.
    case pkcS12Import = -306
    /// PKCS12 data is empty.
    case pkcS12EmptyData = -305
    /// PKCS12 data cannot be read or is malformed.
    case pkcS12Decode = -311
    /// PKCS12 data password incorrect.
    case pkcS12AuthFailed = -312
    /// PKCS12 data wrong password.
    case pkcS12Password = -313
    /// PKCS12 data password required.
    case pkcS12PasswordRequired = -314
    /// PKCS12 data contains no identities.
    case pkcS12NoItems = -307
    /// PKCS12 data contains multiple identities.
    case pkcS12MultipleItems = -309

    /// Keychain cannot be searched.
    case keychainCopyMatching = -401
    /// Keychain does not contain private key.
    case keychainItemNotFound = -302
    /// Keychain does not contain certificate.
    case keychainCreateIdentity = -303
}

enum Environment {
    case none
    case sandbox
    case production
    case auto
}

enum EnvironmentOptions {
    case none
    case sandbox(value: Environment)
    case production(value: Environment)
    case any(value: Environment)
}
