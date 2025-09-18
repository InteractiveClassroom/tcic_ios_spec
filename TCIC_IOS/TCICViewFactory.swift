//
//  TCICViewFactory.swift
//  tcic_client_ios
//
//  Created by joyxian on 2025/7/16.
//

import Foundation
import Flutter
import UIKit
// FLNativeView 只负责持有 UIView
open class FLNativeView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(view: UIView) {
        self._view = view
        super.init()
    }

   public func view() -> UIView {
        return _view
    }
}


// FLNativeViewFactory 让用户重写 createNativeView
open class TCICViewFactory: NSObject, NativeViewCreator {
    private var messenger: FlutterBinaryMessenger

    public init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    // 用户重写这个方法，返回自定义 UIView
   open func createNativeView(
        frame: CGRect,
        viewId: Int64,
        args: Any?
    ) -> UIView {
        // 默认返回空白视图，用户重写
        return UIView(frame: frame)
    }

   public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        let nativeView = createNativeView(frame: frame, viewId: viewId, args: args)
        return FLNativeView(view: nativeView)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
