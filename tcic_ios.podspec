Pod::Spec.new do |s|
  s.name             = 'tcic_ios'
  s.version          = '1.0.0'
  s.summary          = 'Flutter module as iOS framework with manager'
  s.homepage         = 'https://cloud.tencent.com/solution/interactive-classroom'
  # 确保 LICENSE 文件存在，或者暂时注释掉下面一行
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'YourName' => 'your.email@example.com' }
  s.platform         = :ios, '12.0'  # 修改为 12.0 以避免警告
  
  s.source = { :http => "https://ios.qcloudclass.com/#{s.version}/tcic_ios-#{s.version}.zip" }

  s.vendored_frameworks = 'build/ios-framework/Release/*.xcframework'
  s.source_files = 'TCIC_IOS/**/*.{swift,h,m}'

  s.dependency 'TXIMSDK_Plus_iOS_XCFramework', "8.6.7019"
  s.dependency 'TXLiteAVSDK_Professional', '~>12.6.18866'

  s.swift_version = '5.0'
  s.requires_arc = true
end