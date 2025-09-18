//
//  TCICConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICConfig {
    public var token: String
    public var classId: String
    public var userId: String
    public var role: Int?
    public var langConfig: String?
    public var isLatestBackend: Bool = false
    public var isTestBackend: Bool = false
    
    public var headerComponentConfig: TCICHeaderComponentConfig?
    public var messageComponentConfig: TCICMessageComponentConfig?
    public var videoComponentConfig: TCICVideoComponentConfig?
    public var fontConfig: TCICFontConfig?
    public var settingComponentConfig: TCICSettingComponentConfig?
    public var whiteBoardComponentConfig: TCICWhiteBoardComponentConfig?
    public var membersComponentConfig: TCICMembersComponentConfig?
    
    
    public init(token: String,
                classId: String,
                userId: String,
                role: Int? = nil,
                langConfig: String? = nil,
                isLatestBackend: Bool = false,
                isTestBackend: Bool = false,
                headerComponentConfig: TCICHeaderComponentConfig? = nil,
                messageComponentConfig: TCICMessageComponentConfig? = nil,
                videoComponentConfig: TCICVideoComponentConfig? = nil,
                fontConfig: TCICFontConfig? = nil,
                settingComponentConfig: TCICSettingComponentConfig? = nil,
                whiteBoardComponentConfig: TCICWhiteBoardComponentConfig? = nil,
                membersComponentConfig: TCICMembersComponentConfig? = nil) {
        
        self.token = token
        self.classId = classId
        self.userId = userId
        self.role = role
        self.langConfig = langConfig
        self.isLatestBackend = isLatestBackend
        self.isTestBackend = isTestBackend
        self.headerComponentConfig = headerComponentConfig
        self.messageComponentConfig = messageComponentConfig
        self.videoComponentConfig = videoComponentConfig
        self.fontConfig = fontConfig
        self.settingComponentConfig = settingComponentConfig
        self.whiteBoardComponentConfig = whiteBoardComponentConfig
        self.membersComponentConfig = membersComponentConfig
    }
    
    // MARK: - toMap 方法
    
    public func toMap() -> [String: Any] {
        var map: [String: Any] = [
            "token": token,
            "classId": classId,
            "userId": userId,
            "role": role,
            "isLatestBackend": isLatestBackend,
            "isTestBackend": isTestBackend
        ]
        
        if let langConfig = langConfig {
            map["langConfig"] = langConfig
        }
        
        if let fontConfig = fontConfig {
            map["fontConfig"] = fontConfig.toMap()
        }
        
        if let headerComponentConfig = headerComponentConfig {
            map["headerComponentConfig"] = headerComponentConfig.toMap()
        }
        
        if let messageComponentConfig = messageComponentConfig {
            map["messageComponentConfig"] = messageComponentConfig.toMap()
        }
        
        if let videoComponentConfig = videoComponentConfig {
            map["videoComponentComponentConfig"] = videoComponentConfig.toMap()
        }
        
        if let settingComponentConfig = settingComponentConfig {
            map["settingComponentConfig"] = settingComponentConfig.toMap()
        }
        
        if let whiteBoardComponentConfig = whiteBoardComponentConfig {
            map["whiteBoardComponentConfig"] = whiteBoardComponentConfig.toMap()
        }
        
        if let membersComponentConfig = membersComponentConfig {
            map["membersComponentConfig"] = membersComponentConfig.toMap()
        }
        
        return map
    }
}
