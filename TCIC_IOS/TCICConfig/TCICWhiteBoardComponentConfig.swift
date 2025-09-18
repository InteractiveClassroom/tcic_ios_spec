//
//  TCICWhiteBoardComponentConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICWhiteBoardComponentConfig {
    
    public var enableCreateBoard: Bool = true
    public var enableBoardList: Bool = true
    public var enableSwitchPage: Bool = true
    
    public init() {
        // 默认初始化
    }
    
    public func toMap() -> [String: Any] {
        return [
            "enableCreateBoard": enableCreateBoard,
            "enableBoardList": enableBoardList,
            "enableSwitchPage": enableSwitchPage
        ]
    }
}
