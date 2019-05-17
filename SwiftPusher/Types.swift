//
//  Types.swift
//  SwiftPusher
//
//  Created by Abdullah Selek on 03/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import Foundation

/// The current and past data formats supported by APNs. For more information see Apple documentation under 'Legacy Information'.
public enum NotificationType {
    /// The 'Simple Notification Format'. The oldest format simply concatenates the device token and payload.
    case simple
    /// The 'Enhanced Notification Format'. Similar to the previous format but includes and identifier and expiration date.
    case enchanced
    /// The 'Binary Interface and Notification Format'. The latest more extensible format that allows for attributes like priority.
    case binary
}

/// Types of push certificates.
public enum CertType {
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

enum Constants {
    static let ErrorReasonCodeKey = "ErrorReasonCodeKey"
}

protocol PusherErrorDescription  {
    var description: String { get }
}

/// List all error codes.
public enum PusherError: Int, PusherErrorDescription {
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

    public var description: String {
        switch self {
        case .none:
            return "No error, that's odd"
        case .apnProcessing:
            return "APN processing error"
        case .apnMissingDeviceToken:
            return "APN missing device token"
        case .apnMissingTopic:
            return "APN missing topic"
        case .apnMissingPayload:
            return "APN missing payload"
        case .apnInvalidTokenSize:
            return "APN invalid token size"
        case .apnInvalidTopicSize:
            return "APN invalid topic size"
        case .apnInvalidPayloadSize:
            return "APN invalid payload size"
        case .apnInvalidTokenContent:
            return "APN invalid token"
        case .apnUnknownReason:
            return "APN unknown error code"
        case .apnShutdown:
            return "APN shutdown"
        case .apnUnknownErrorCode:
            return "APN unknown error code"
        case .pushResponseCommand:
            return "Push response command unknown"
        case .pushNotConnected:
            return "Push reconnect requires connection"
        case .pushWriteFail:
            return "Push not fully sent"
        case .feedbackLength:
            return "Feedback data length unexpected"
        case .feedbackTokenLength:
            return "Feedback token length unexpected"
        case .socketCreate:
            return "Socket cannot be created"
        case .socketConnect:
            return "Socket connecting failed"
        case .socketResolveHostName:
            return "Socket host cannot be resolved"
        case .socketFileControl:
            return "Socket file control failed"
        case .socketOptions:
            return "Socket options cannot be set"
        case .sslConnection:
            return "SSL connection cannot be set"
        case .sslContext:
            return "SSL context cannot be created"
        case .sslIOFuncs:
            return "SSL callbacks cannot be set"
        case .sslPeerDomainName:
            return "SSL peer domain name cannot be set"
        case .sslCertificate:
            return "SSL certificate cannot be set"
        case .sslDroppedByServer:
            return "SSL handshake dropped by server"
        case .sslAuthFailed:
            return "SSL handshake authentication failed"
        case .sslHandshakeFail:
            return "SSL handshake failed"
        case .sslHandshakeUnknownRootCert:
            return "SSL handshake root not a known anchor"
        case .sslHandshakeNoRootCert:
            return "SSL handshake chain not verifiable to root"
        case .sslHandshakeCertExpired:
            return "SSL handshake expired certificates"
        case .sslHandshakeXCertChainInvalid:
            return "SSL handshake invalid certificate chain"
        case .sslHandshakeClientCertRequested:
            return "SSL handshake expecting client cert"
        case .sslHandshakeServerAuthCompleted:
            return "SSL handshake auth interrupted"
        case .sslHandshakePeerCertExpired:
            return "SSL handshake certificate expired"
        case .sslHandshakePeerCertRevoked:
            return "SSL handshake certificate revoked"
        case .sslHandshakePeerCertUnknown:
            return "SSL handshake certificate unknown"
        case .sslHandshakeInternalError:
            return "SSL handshake internal error"
        case .sslInDarkWake:
            return "SSL handshake in dark wake"
        case .sslHandshakeClosedAbort:
            return "SSL handshake connection closed via error"
        case .sslHandshakeTimeout:
            return "SSL handshake timeout"
        case .readDroppedByServer:
            return "Read connection dropped by server"
        case .readClosedAbort:
            return "Read connection error"
        case .readClosedGraceful:
            return "Read connection closed"
        case .readFail:
            return "Read failed"
        case .writeDroppedByServer:
            return "Write connection dropped by server"
        case .writeClosedAbort:
            return "Write connection error"
        case .writeClosedGraceful:
            return "Write connection closed"
        case .writeFail:
            return "Write failed"
        case .identityCopyCertificate:
            return "Identity does not contain certificate"
        case .identityCopyPrivateKey:
            return "Identity does not contain private key"
        case .pkcS12Import:
            return "PKCS12 data cannot be imported"
        case .pkcS12EmptyData:
            return "PKCS12 data is empty"
        case .pkcS12Decode:
            return "PKCS12 data cannot be read or is malformed"
        case .pkcS12AuthFailed:
            return "PKCS12 data password incorrect"
        case .pkcS12Password:
            return "PKCS12 data wrong password"
        case .pkcS12PasswordRequired:
            return "PKCS12 data password required"
        case .pkcS12NoItems:
            return "PKCS12 data contains no identities"
        case .pkcS12MultipleItems:
            return "PKCS12 data contains multiple identities"
        case .keychainCopyMatching:
            return "Keychain cannot be searched"
        case .keychainItemNotFound:
            return "Keychain does not contain private key"
        case .keychainCreateIdentity:
            return "Keychain does not contain certificate"
        }
    }

    public static func error(withCode code: PusherError, reason: Int) -> Error {
        var description = code.description
        description = String(format: "%@ %d", description, reason)
        var info = [NSLocalizedDescriptionKey: description]
        info[Constants.ErrorReasonCodeKey] = String(reason)
        return NSError(domain: "", code: code.rawValue, userInfo: info) as Error
    }
}

public enum Environment {
    case none
    case sandbox
    case production
    case auto
}

public enum EnvironmentOptions {
    case none
    case sandbox(value: Environment)
    case production(value: Environment)
    case any(value: Environment)
}
