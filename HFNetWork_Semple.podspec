#
# Be sure to run `pod lib lint HFNetWork_Semple.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HFNetWork_Semple'
  s.version          = '0.1.5'
  s.summary          = '网络请求'
  s.description      = <<-DESC
简单网络请求工具
                       DESC
  s.homepage         = 'https://github.com/Components-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuhongfei' => '13718045729@163.com' }
  s.source           = { :git => 'https://github.com/Components-iOS/HFNetWork_Semple.git', :tag => s.version.to_s }
  s.platform     = :ios, "13.0"
  s.ios.deployment_target = '13.0'
  s.source_files = 'HFNetWork_Semple/Classes/**/*'
  s.dependency 'AFNetworking', '4.0.1'
  s.dependency 'Masonry', '1.1.0'
  s.requires_arc = true
end
