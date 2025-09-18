//
//  TCICHeaderIconConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICHeaderIconConfig {
    
    public var micIcon: String?
    public var micDisableIcon: String?
    public var cameraIcon: String?
    public var cameraDisableIcon: String?
    public var handupIcon: String?
    public var screenShareIcon: String?
    public var messageIcon: String?
    public var coursewareIcon: String?
    public var settingIcon: String?
    public var membersIcon: String?
    
    public init() {
        // 默认初始化
    }
    
    public func toMap() -> [String: Any?] {
        return [
            "micIcon": micIcon,
            "micDisableIcon": micDisableIcon,
            "cameraIcon": cameraIcon,
            "cameraDisableIcon": cameraDisableIcon,
            "handupIcon": handupIcon,
            "screenShareIcon": screenShareIcon,
            "messageIcon": messageIcon,
            "coursewareIcon": coursewareIcon,
            "settingIcon": settingIcon,
            "membersIcon": membersIcon
        ]
    }
}
