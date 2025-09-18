//
//  TCICMembersComponentConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICMembersComponentConfig {
    
    public var enableStageUpDownAction: Bool = false
    
    public init() {
        // 默认初始化
    }
    
    public func toMap() -> [String: Any] {
        return [
            "enableStageUpDownAction": enableStageUpDownAction
        ]
    }
}
