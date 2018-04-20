
Pod::Spec.new do |s|

  s.name         = "SocialAPPKit"
  s.version      = "0.0.6"
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
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}', 'SocialAPPKit/WechatAppKit/**/*.{h,m}'
    end

    #TencentQQ
    s.subspec 'TencentQQAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}', 'SocialAPPKit/TencentQQAppKit/**/*.{h,m}'
    end
    
    #facebook
    s.subspec 'FaceBookAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}', 'SocialAPPKit/FaceBookAppKit/**/*.{h,m}'
    end

    #twitter
    s.subspec 'TwitterAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}', 'SocialAPPKit/TwitterAppKit/**/*.{h,m}'
    end

    #alipay
    s.subspec 'AlipayAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}', 'SocialAPPKit/AlipayAppKit/**/*.{h,m}'
    end

    #SinaWeibo
    s.subspec 'SinaWeiboAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}', 'SocialAPPKit/SinaWeiboAppKit/**/*.{h,m}'
    end
end
