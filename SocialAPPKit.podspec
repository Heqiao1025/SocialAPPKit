#
# Be sure to run `pod lib lint fcne.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SocialAPPKit'
  s.version          = '0.0.2'
  s.summary          = '社会化组件功能'
  s.homepage         = 'https://github.com/Heqiao1025/SocialAPPKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ForC' => 'heqiao.china@gmail.com' }
  s.source           = { :git => 'https://github.com/Heqiao1025/SocialAPPKit.git', :tag => s.version.to_s }
  s.resource_bundles = {
    'SocialAPPKit' => ['SocialAPPKit/*.xcassets','SocialAPPKit/**/*.{xib}']
  }
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.frameworks   = 'UIKit', 'Foundation'

  # s.dependency 'AFNetworking', '~> 2.3'
end
