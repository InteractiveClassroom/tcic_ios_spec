//
//  TCICVideoComponentConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation

public class TCICVideoComponentConfig {
    
    // 自定义UI构建闭包，返回 NativeViewCreator
    // 对应 Java 的 VideoBuilder 接口
    public typealias VideoBuilder = () -> NativeViewCreator
    
    public var videoFloatBuilder: VideoBuilder?
    public var videoFloatBuilderWidth: Double = 0
    public var videoFloatBuilderHeight: Double = 0
    public var videoActionBuilder: VideoBuilder?
    public var videoActionBuilderWidth: Double = 0
    public var videoActionBuilderHeight: Double = 0

    public init() {
        // 默认初始化
    }

    public func toMap() -> [String: Any] {
        var map: [String: Any] = [
            "videoFloatBuilderWidth": videoFloatBuilderWidth,
            "videoFloatBuilderHeight": videoFloatBuilderHeight,
            "videoActionBuilderWidth": videoActionBuilderWidth,
            "videoActionBuilderHeight": videoActionBuilderHeight
        ]
        return map
    }
}
