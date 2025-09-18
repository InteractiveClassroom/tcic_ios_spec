//
//  TCICCallback.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/16.
//

import Foundation

open class TCICCallback {
    public init() {}

    public var onJoinedClassSuccessBlock: (() -> Void)?
    public var afterExitedClassBlock: (() -> Void)?
    public var onJoinedClassFailedBlock: (() -> Void)?
    public var onKickedOffClassBlock: (() -> Void)?
    public var onMemberJoinedClassBlock: (([String: Any]) -> Void)?
    public var onMemberLeaveClassBlock: (([String: Any]) -> Void)?
    public var onReceivedMessageBlock: (([String: Any]) -> Void)?
    public var onErrorBlock: ((String, String) -> Void)?

    open func onJoinedClassSuccess() {
        onJoinedClassSuccessBlock?()
    }

    open func afterExitedClass() {
        afterExitedClassBlock?()
    }

    open func onJoinedClassFailed() {
        onJoinedClassFailedBlock?()
    }

    open func onKickedOffClass() {
        onKickedOffClassBlock?()
    }

    open func onMemberJoinedClass(_ userId: [String: Any]) {
        onMemberJoinedClassBlock?(userId)
    }

    open func onMemberLeaveClass(_ userId: [String: Any]) {
        onMemberLeaveClassBlock?(userId)
    }

    open func onReceivedMessage(_ messageJson: [String: Any]) {
        onReceivedMessageBlock?(messageJson)
    }

    open func onError(code: String, message: String) {
        onErrorBlock?(code, message)
    }
}
