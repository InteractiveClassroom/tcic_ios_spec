//
//  TCICSettingComponentConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICSettingComponentConfig {
    public var enableAudioSetting: Bool = true
    public var enableVideoSetting: Bool = true
    public var enableGeneralSetting: Bool = true
    public var showMemberJoinExitInfo: Bool = true
    public var showMemberHansupInfo: Bool = true

    public func toMap() -> [String: Any] {
        return [
            "enableAudioSetting": enableAudioSetting,
            "enableVideoSetting": enableVideoSetting,
            "enableGeneralSetting": enableGeneralSetting,
            "showMemberJoinExitInfo": showMemberJoinExitInfo,
            "showMemberHansupInfo": showMemberHansupInfo
        ]
    }
}
