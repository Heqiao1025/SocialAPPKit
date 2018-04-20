
Pod::Spec.new do |s|

  s.name         = "SocialAPPKit"
  s.version      = "0.1.0"
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

    #SocialAPPCore
    s.subspec 'SocialAPPCore' do |subspec|
      subspec.source_files = 'SocialAPPKit/SocialAppCode/**/*.{h,m}'
    end

    #wechat
    s.subspec 'WechatAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/WechatAppKit/**/*.{h,m}'
      subspec.dependency 'SocialAPPKit/SocialAPPCore'
    end

    #TencentQQ
    s.subspec 'TencentQQAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/TencentQQAppKit/**/*.{h,m}'
      subspec.dependency 'SocialAPPKit/SocialAPPCore'
    end
    
    #facebook
    s.subspec 'FaceBookAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/FaceBookAppKit/**/*.{h,m}'
      subspec.dependency 'SocialAPPKit/SocialAPPCore'
    end

    #twitter
    s.subspec 'TwitterAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/TwitterAppKit/**/*.{h,m}'
      subspec.dependency 'SocialAPPKit/SocialAPPCore'
    end

    #alipay
    s.subspec 'AlipayAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/AlipayAppKit/**/*.{h,m}'
      subspec.dependency 'SocialAPPKit/SocialAPPCore'
    end

    #SinaWeibo
    s.subspec 'SinaWeiboAppKit' do |subspec|
      subspec.source_files = 'SocialAPPKit/SinaWeiboAppKit/**/*.{h,m}'
      subspec.dependency 'SocialAPPKit/SocialAPPCore'
    end
end
