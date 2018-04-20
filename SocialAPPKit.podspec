
Pod::Spec.new do |s|

  s.name         = "SocialAPPKit"
  s.version      = "0.0.5"
  s.summary      = "社交化APP轻量级功能组件"
  s.homepage     = "https://github.com/Heqiao1025/SocialAPPKit"
  s.license      = {
    :type => 'MIT',
    :file => 'LICENSE'
  }
  s.author       = { "ForC" => "heqiao.china@gmail.com" }
  s.source       = { :git => "https://github.com/Heqiao1025/SocialAPPKit.git", :tag => "#{s.version}" }
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.resource_bundles = {
        'SocialAPPKitAssets' => ['SocialAPPKit/*.xcassets']
  }

    #wechat
    s.subspec 'WechatAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}, SocialAPPKit/WechatAppKit/**/*.{h,m}'
    end

    s.subspec 'TencentQQAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}, SocialAPPKit/TencentQQAppKit/**/*.{h,m}'
    end
    
end
