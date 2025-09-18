import Foundation
import FlutterPluginRegistrant
import Flutter
import SwiftUI
import UIKit

public protocol MethodChannelResult {
    func success(_ result: Any?)
    func error(_ code: String, _ message: String, _ details: Any?)
    func notImplemented()
}

public class TCICManager: NSObject {
    
    public static let shared = TCICManager()
    
    private(set) public var Tengine: FlutterEngine!
    private(set) public var methodChannel: FlutterMethodChannel!
    private(set) public var registrar: FlutterPluginRegistrar!
    
    private weak var currentFlutterViewController: UIViewController?
    
    private var registeredViewCreators: [String: Bool] = [:]
    
    public var callback: TCICCallback?
    
    private override init() {
        super.init()
    }
    
    /// 初始化 Flutter 引擎和通信通道
    public func initialize() {
        print("Initialized Flutter Engine");
        if Tengine != nil {
            // 已初始化，直接返回
            return
        }
        
        Tengine = FlutterEngine(name: "tcic_flutter_engine")
        Tengine.run()

        GeneratedPluginRegistrant.register(with: Tengine);
        
        methodChannel = FlutterMethodChannel(name: "tcic_method_channel", binaryMessenger: Tengine.binaryMessenger)
        
        methodChannel.setMethodCallHandler { [weak self] call, result in
            self?.handleMethodCall(call: call, result: result)
        }
        
        registrar = Tengine.registrar(forPlugin: "tcic_plugin");
        
        
        print("Flutter engine initialized successfully")
    }
    
    private func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
        print("Received method call: \(call.method)")
        
        switch call.method {
        case "getCurrentConfig":
            if let map = getMapConfig() {
                result(map)
            } else {
                result(FlutterError(code: "NO_CONFIG", message: "Config not set", details: nil))
            }
            
        case "test":
            if let args = call.arguments {
                print("Test method called with arguments: \(args)")
            }
            let response = ["test": "12312", "status": "success"]
            result(response)
            
        case "onJoinedClassSuccess":
            callback?.onJoinedClassSuccess()
            result(true)
            
        case "afterExitedClass":
            if callback != nil {
                print("callback is not null");
            }
            callback?.afterExitedClass();
            result(true)
            
        case "onJoinedClassFailed":
            if callback != nil {
                print("callback is not null");
            }
            callback?.onJoinedClassFailed()
            result(true)
            
        case "onKickedOffClass":
            callback?.onKickedOffClass()
            result(true)
            
        case "onMemberJoinedClass":
            if let args = call.arguments as? [String: Any] {
                callback?.onMemberJoinedClass(args)
            }
            result(true)
            
        case "onMemberLeaveClass":
            if let args = call.arguments as? [String: Any] {
                callback?.onMemberLeaveClass(args)
            }
            result(true)
            
        case "onRecivedMessage":
            if let args = call.arguments as? [String: Any] {
                callback?.onReceivedMessage(args)
            }
            result(true)
            
        case "onError":
            if let args = call.arguments as? [String: Any] {
                let code = args["code"] as? String ?? ""
                let msg = args["msg"] as? String ?? ""
                callback?.onError(code: code, message: msg)
            }
            result(true)
            
        case "closeFlutterActivity":
            closeFlutterActivity()
            result(true)
            
        case "isViewCreatorRegistered":
            if let viewType = call.arguments as? String {
                result(isViewCreatorRegistered(viewType))
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Expected string argument", details: nil))
            }
            
        case "getRegisteredViewCreators":
            result(getRegisteredViewCreators())
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    public func openTCICPage(from presentingVC: UIViewController) {
        guard let engine = Tengine else {
            print("Flutter engine not initialized")
            return
        }
        let flutterVC = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        registerFlutterViewController(flutterVC)
        
        if let nav = presentingVC.navigationController {
            // 直接 push 到当前导航栈
            nav.pushViewController(flutterVC, animated: true)
        } else {
            // 没有导航栈，present 一个全屏的 UINavigationController
            let nav = UINavigationController(rootViewController: flutterVC)
            nav.setNavigationBarHidden(true, animated: false)
            nav.modalPresentationStyle = .fullScreen
            presentingVC.present(nav, animated: true, completion: nil)
        }
    }
    
    public func setCallback(_ cb: TCICCallback) {
        callback = cb;
    }
    
    public func registerFlutterViewController(_ vc: UIViewController) {
        currentFlutterViewController = vc
    }
    
    public func unregisterFlutterViewController(_ vc: UIViewController) {
        if currentFlutterViewController === vc {
            currentFlutterViewController = nil
        }
    }
    
    public func closeFlutterActivity() {
        print("closeFlutterActivity");
        if let vc = currentFlutterViewController {
            DispatchQueue.main.async {
                vc.dismiss(animated: true, completion: nil)
            }
            currentFlutterViewController = nil
        }
    }
    
    // MARK: - PlatformView 注册
    
    public func registerNativeViewCreator(viewType: String, creator: NativeViewCreator) {
        guard Tengine != nil else {
            print("Flutter engine not initialized")
            return
        }
        guard registrar != nil else {
            print("Flutter registrar not initialized")
            return
        }
        if registeredViewCreators[viewType] == true {
            print("ViewCreator for \(viewType) already registered, skip.")
            return
        }
        registrar.register(creator, withId: viewType);
        registeredViewCreators[viewType] = true
    }
    
    public func isViewCreatorRegistered(_ viewType: String) -> Bool {
        return registeredViewCreators[viewType] ?? false
    }
    
    public func getRegisteredViewCreators() -> [String] {
        return Array(registeredViewCreators.keys)
    }
    
    // MARK: - 配置管理
    
    private var config: TCICConfig?
    
    public func setConfig(_ config: TCICConfig) {
        self.config = config
         
        // 注册各个组件的 NativeViewCreator
        if let headerConfig = config.headerComponentConfig {
            if let leftBuilder = headerConfig.headerLeftBuilder {
                registerNativeViewCreator(viewType: "native_header_left_view", creator: leftBuilder())
            }
            if let headerBuilder = headerConfig.headerBuilder {
                registerNativeViewCreator(viewType: "native_header_view", creator: headerBuilder())
            }
            if let actionsBuilder = headerConfig.headerActionsBuilder {
                registerNativeViewCreator(viewType: "native_header_action_view", creator: actionsBuilder())
            }
            if let rightBuilder = headerConfig.headerRightBuilder {
                registerNativeViewCreator(viewType: "native_header_right_view", creator: rightBuilder())
            }
        }
        
        if let messageConfig = config.messageComponentConfig {
            if let messageHeaderBuilder = messageConfig.messageHeaderBuilder {
                registerNativeViewCreator(viewType: "native_message_header_view", creator: messageHeaderBuilder())
            }
            if let messageBubbleBuilder = messageConfig.messageBubbleBuilder {
                registerNativeViewCreator(viewType: "native_message_bubble_view", creator: messageBubbleBuilder())
            }
            if let messageItemBuilder = messageConfig.messageItemBuilder {
                registerNativeViewCreator(viewType: "native_message_item_view", creator: messageItemBuilder())
            }
            if let messageRowBuilder = messageConfig.messageRowBuilder {
                registerNativeViewCreator(viewType: "native_message_row_view", creator: messageRowBuilder())
            }
        }
        
        if let videoConfig = config.videoComponentConfig {
            if let videoActionBuilder = videoConfig.videoActionBuilder {
                registerNativeViewCreator(viewType: "native_video_action_view", creator: videoActionBuilder())
            }
            if let videoFloatBuilder = videoConfig.videoFloatBuilder {
                registerNativeViewCreator(viewType: "native_video_float_view", creator: videoFloatBuilder())
            }
        }
        
        // 调用 Flutter 更新配置
        if let map = getMapConfig() {
            callFlutterMethod(method: "updateConfig", arguments: map, result: DefaultMethodChannelResult())
        }
    }
    
    private func getMapConfig() -> [String: Any]? {
        return config?.toMap()
    }
    
    // MARK: - 调用 Flutter 方法
    
    public func callFlutterMethod(method: String, arguments: [String: Any], result: MethodChannelResult?) {
        guard let channel = methodChannel else {
            print("Method channel not initialized")
            result?.error("CHANNEL_NOT_INITIALIZED", "Method channel not initialized", nil)
            return
        }
        
        channel.invokeMethod(method, arguments: arguments) { res in
            if let error = res as? FlutterError {
                result?.error(error.code, error.message ?? "", error.details)
            } else {
                result?.success(res)
            }
        }
    }
    
    // MARK: - 退出课堂示例
    
    public func quitClass() {
        methodChannel?.invokeMethod("quitClass", arguments: nil)
    }
    
    @available(iOS 13.0, *)
    public struct TPage: UIViewControllerRepresentable {
        public init() {}  // 显式声明 public 初始化器

        public func makeUIViewController(context: Context) -> some UIViewController {
            let engine = TCICManager.shared.Tengine;
            return FlutterViewController(engine: engine!, nibName: nil, bundle: nil)
        }
        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
}

// MARK: - 默认 MethodChannelResult 实现

class DefaultMethodChannelResult: MethodChannelResult {
    func success(_ result: Any?) {
        print("Flutter call success: \(String(describing: result))")
    }
    
    func error(_ code: String, _ message: String, _ details: Any?) {
        print("Flutter call error: \(code) - \(message)")
    }
    
    func notImplemented() {
        print("Flutter call not implemented")
    }
}

// MARK: - NativeViewCreator 协议示例

// 你需要定义 NativeViewCreator 协议，和 Java 版本的 NativeViewCreator 对应
// 这里是示例协议，具体实现根据你的需求调整

public protocol NativeViewCreator: FlutterPlatformViewFactory {
    // 你可以添加自定义方法
}
