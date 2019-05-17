//
//  TypesTests.swift
//  SwiftPusherTests
//
//  Created by Abdullah Selek on 17/05/2019.
//  Copyright © 2019 Abdullah Selek. All rights reserved.
//

import XCTest

@testable import SwiftPusher

class TypesTests: XCTestCase {

    func testPusherErrorDescription() {
        XCTAssertEqual(PusherError.none.description, "No error, that's odd")
        XCTAssertEqual(PusherError.apnProcessing.description, "APN processing error")
        XCTAssertEqual(PusherError.apnMissingDeviceToken.description, "APN missing device token")
        XCTAssertEqual(PusherError.apnMissingTopic.description, "APN missing topic")
        XCTAssertEqual(PusherError.apnMissingPayload.description, "APN missing payload")
        XCTAssertEqual(PusherError.apnInvalidTokenSize.description, "APN invalid token size")
        XCTAssertEqual(PusherError.apnInvalidTopicSize.description, "APN invalid topic size")
        XCTAssertEqual(PusherError.apnInvalidPayloadSize.description, "APN invalid payload size")
        XCTAssertEqual(PusherError.apnInvalidTokenContent.description, "APN invalid token")
        XCTAssertEqual(PusherError.apnUnknownReason.description, "APN unknown error code")
        XCTAssertEqual(PusherError.apnShutdown.description, "APN shutdown")
        XCTAssertEqual(PusherError.apnUnknownErrorCode.description, "APN unknown error code")
        XCTAssertEqual(PusherError.pushResponseCommand.description, "Push response command unknown")
        XCTAssertEqual(PusherError.pushNotConnected.description, "Push reconnect requires connection")
        XCTAssertEqual(PusherError.pushWriteFail.description, "Push not fully sent")
        XCTAssertEqual(PusherError.feedbackLength.description, "Feedback data length unexpected")
        XCTAssertEqual(PusherError.feedbackTokenLength.description, "Feedback token length unexpected")
        XCTAssertEqual(PusherError.socketCreate.description, "Socket cannot be created")
        XCTAssertEqual(PusherError.socketConnect.description, "Socket connecting failed")
        XCTAssertEqual(PusherError.socketResolveHostName.description, "Socket host cannot be resolved")
        XCTAssertEqual(PusherError.socketFileControl.description, "Socket file control failed")
        XCTAssertEqual(PusherError.socketOptions.description, "Socket options cannot be set")
        XCTAssertEqual(PusherError.sslConnection.description, "SSL connection cannot be set")
        XCTAssertEqual(PusherError.sslContext.description, "SSL context cannot be created")
        XCTAssertEqual(PusherError.sslIOFuncs.description, "SSL callbacks cannot be set")
        XCTAssertEqual(PusherError.sslPeerDomainName.description, "SSL peer domain name cannot be set")
        XCTAssertEqual(PusherError.sslCertificate.description, "SSL certificate cannot be set")
        XCTAssertEqual(PusherError.sslDroppedByServer.description, "SSL handshake dropped by server")
        XCTAssertEqual(PusherError.sslAuthFailed.description, "SSL handshake authentication failed")
        XCTAssertEqual(PusherError.sslHandshakeFail.description, "SSL handshake failed")
        XCTAssertEqual(PusherError.sslHandshakeUnknownRootCert.description, "SSL handshake root not a known anchor")
        XCTAssertEqual(PusherError.sslHandshakeNoRootCert.description, "SSL handshake chain not verifiable to root")
        XCTAssertEqual(PusherError.sslHandshakeCertExpired.description, "SSL handshake expired certificates")
        XCTAssertEqual(PusherError.sslHandshakeXCertChainInvalid.description, "SSL handshake invalid certificate chain")
        XCTAssertEqual(PusherError.sslHandshakeClientCertRequested.description, "SSL handshake expecting client cert")
        XCTAssertEqual(PusherError.sslHandshakeServerAuthCompleted.description, "SSL handshake auth interrupted")
        XCTAssertEqual(PusherError.sslHandshakePeerCertExpired.description, "SSL handshake certificate expired")
        XCTAssertEqual(PusherError.sslHandshakePeerCertRevoked.description, "SSL handshake certificate revoked")
        XCTAssertEqual(PusherError.sslHandshakePeerCertUnknown.description, "SSL handshake certificate unknown")
        XCTAssertEqual(PusherError.sslHandshakeInternalError.description, "SSL handshake internal error")
        XCTAssertEqual(PusherError.sslInDarkWake.description, "SSL handshake in dark wake")
        XCTAssertEqual(PusherError.sslHandshakeClosedAbort.description, "SSL handshake connection closed via error")
        XCTAssertEqual(PusherError.sslHandshakeTimeout.description, "SSL handshake timeout")
        XCTAssertEqual(PusherError.readDroppedByServer.description, "Read connection dropped by server")
        XCTAssertEqual(PusherError.readClosedAbort.description, "Read connection error")
        XCTAssertEqual(PusherError.readClosedGraceful.description, "Read connection closed")
        XCTAssertEqual(PusherError.readFail.description, "Read failed")
        XCTAssertEqual(PusherError.writeDroppedByServer.description, "Write connection dropped by server")
        XCTAssertEqual(PusherError.writeClosedAbort.description, "Write connection error")
        XCTAssertEqual(PusherError.writeClosedGraceful.description, "Write connection closed")
        XCTAssertEqual(PusherError.writeFail.description, "Write failed")
        XCTAssertEqual(PusherError.identityCopyCertificate.description, "Identity does not contain certificate")
        XCTAssertEqual(PusherError.identityCopyPrivateKey.description, "Identity does not contain private key")
        XCTAssertEqual(PusherError.pkcS12Import.description, "PKCS12 data cannot be imported")
        XCTAssertEqual(PusherError.pkcS12EmptyData.description, "PKCS12 data is empty")
        XCTAssertEqual(PusherError.pkcS12Decode.description, "PKCS12 data cannot be read or is malformed")
        XCTAssertEqual(PusherError.pkcS12AuthFailed.description, "PKCS12 data password incorrect")
        XCTAssertEqual(PusherError.pkcS12Password.description, "PKCS12 data wrong password")
        XCTAssertEqual(PusherError.pkcS12PasswordRequired.description, "PKCS12 data password required")
        XCTAssertEqual(PusherError.pkcS12NoItems.description, "PKCS12 data contains no identities")
        XCTAssertEqual(PusherError.pkcS12MultipleItems.description, "PKCS12 data contains multiple identities")
        XCTAssertEqual(PusherError.keychainCopyMatching.description, "Keychain cannot be searched")
        XCTAssertEqual(PusherError.keychainItemNotFound.description, "Keychain does not contain private key")
        XCTAssertEqual(PusherError.keychainCreateIdentity.description, "Keychain does not contain certificate")
    }

    func testErrorInitWithPusherError() {
        let error = PusherError.error(withCode: .apnInvalidPayloadSize, reason: -7)
        XCTAssertEqual(error.localizedDescription, "APN invalid payload size -7")
    }

}
