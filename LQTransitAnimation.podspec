#
#  Be sure to run `pod spec lint LQTransitAnimation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LQTransitAnimation"
  s.version      = "1.0"
  s.summary      = "自定义转场动画，使用简单"
  s.description  = <<-DESC
  转场动画, 定义了仿AppStore首页的转场和圆形打开/关闭动画
                   DESC

  s.homepage     = "https://github.com/LQi2009/LQTransitAnimation"
  s.license      = "MIT"
  s.author             = { "LiuQiqiang" => "lqq200912408@163.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/LQi2009/LQTransitAnimation.git", :tag => "#{s.version}" }

  s.source_files  = "class/LQTransitAnimation/*.{h,m}"
  s.requires_arc = true

end