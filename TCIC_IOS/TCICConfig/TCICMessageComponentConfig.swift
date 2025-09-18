//
//  TCICMessageComponentConfig.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/10.
//

import Foundation


public class TCICMessageComponentConfig {
    public typealias MessageBuilder = () -> NativeViewCreator
    public var messageItemBuilder: MessageBuilder?
    public var messageItemBuilderWidth: Double = 0
    public var messageItemBuilderHeight: Double = 0
    public var messageHeaderBuilder: MessageBuilder?
    public var messageHeaderBuilderWidth: Double = 0
    public var messageHeaderBuilderHeight: Double = 0
    public var messageBubbleBuilder: MessageBuilder?
    public var messageBubbleBuilderWidth: Double = 0
    public var messageBubbleBuilderHeight: Double = 0
    public var messageRowBuilder: MessageBuilder?
    public var messageRowBuilderWidth: Double = 0
    public var messageRowBuilderHeight: Double = 0

    public init() {
        // 默认初始化
    }

    public func toMap() -> [String: Any] {
        var map: [String: Any] = [
            "messageItemBuilderWidth": messageItemBuilderWidth,
            "messageItemBuilderHeight": messageItemBuilderHeight,
            "messageHeaderBuilderWidth": messageHeaderBuilderWidth,
            "messageHeaderBuilderHeight": messageHeaderBuilderHeight,
            "messageBubbleBuilderWidth": messageBubbleBuilderWidth,
            "messageBubbleBuilderHeight": messageBubbleBuilderHeight,
            "messageRowBuilderWidth": messageRowBuilderWidth,
            "messageRowBuilderHeight": messageRowBuilderHeight
        ]
        return map
    }
}
