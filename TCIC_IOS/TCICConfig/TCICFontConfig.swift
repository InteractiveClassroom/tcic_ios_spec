//
//  TCICFontConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICFontConfig {
    public var fontFamily: String?
    public var fontPath: String?
    public var fontUrl: String?
    public var enableCustomFont: Bool = false


    public func toMap() -> [String: Any?] {
        return [
            "fontFamily": fontFamily,
            "fontPath": fontPath,
            "fontUrl": fontUrl,
            "enableCustomFont": enableCustomFont
        ]
    }
}
