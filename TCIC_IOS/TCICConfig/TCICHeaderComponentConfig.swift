//
//  TCICHeaderComponentConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICHeaderComponentConfig {
    
    // MARK: - 属性
    
    public var isShow: Bool = true
    public var enableHandsUp: Bool = true
    public var enableScreenShare: Bool = true
    public var enableMessage: Bool = true
    public var enableCoureseware: Bool = true
    public var enableSetting: Bool = true
    public var enableMemberList: Bool = true
    public var showClassStatus: Bool = true
    public var showClassTime: Bool = true
    public var showOnlineMemberCount: Bool = true
    public var showQuitButton: Bool = true
    public var showClassLogo: Bool = true
    public var showClassName: Bool = true
    public var showClassInfo: Bool = true
    public var showNetworkStatus: Bool = true
    
    public var iconConfig: TCICHeaderIconConfig?
    
    // 自定义UI构建闭包，返回 NativeViewCreator
    // 对应 Java 的 HeaderBuilder 接口
    public typealias HeaderBuilder = () -> NativeViewCreator
    
    public var headerBuilder: HeaderBuilder?
    public var headerLeftBuilder: HeaderBuilder?
    public var headerRightBuilder: HeaderBuilder?
    public var headerActionsBuilder: HeaderBuilder?
    public var headerLeftBuilderWidth: Double = 100
    public var headerLeftBuilderHeight: Double = 50
    public var headerRightBuilderWidth: Double = 100
    public var headerRightBuilderHeight: Double = 100
    public var headerActionsBuilderWidth: Double = 100
    public var headerActionsBuilderHeight: Double = 50
    
    // MARK: - 构造函数
    
    public init() {
        // 默认值已在属性定义时赋值
    }
    
    // MARK: - toMap 方法
    
    public func toMap() -> [String: Any] {
        var map: [String: Any] = [
            "isShow": isShow,
            "enableHandsUp": enableHandsUp,
            "enableScreenShare": enableScreenShare,
            "enableMessage": enableMessage,
            "enableCoureseware": enableCoureseware,
            "enableSetting": enableSetting,
            "enableMemberList": enableMemberList,
            "showClassStatus": showClassStatus,
            "showClassTime": showClassTime,
            "showOnlineMemberCount": showOnlineMemberCount,
            "showQuitButton": showQuitButton,
            "showClassLogo": showClassLogo,
            "showClassName": showClassName,
            "showClassInfo": showClassInfo,
            "showNetworkStatus": showNetworkStatus,
            "headerLeftBuilderWidth": headerLeftBuilderWidth,
            "headerLeftBuilderHeight": headerLeftBuilderHeight,
            "headerRightBuilderWidth": headerRightBuilderWidth,
            "headerRightBuilderHeight": headerRightBuilderHeight,
            "headerActionsBuilderWidth": headerActionsBuilderWidth,
            "headerActionsBuilderHeight": headerActionsBuilderHeight
        ]
    
        if let iconConfig = iconConfig {
            map["iconConfig"] = iconConfig.toMap()
        }
    
        // 注意：Java 版本没有把自定义 builder 放到 map 里，这里也不放
    
        return map
    }
}
