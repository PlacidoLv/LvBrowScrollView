#
#  Be sure to run `pod spec lint LvBrowScrollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "LvBrowScrollView"
s.version      = "0.0.1"
s.summary      = "仿微信朋友圈图片浏览"
s.description  = "仿微信朋友圈图片浏览。"
s.homepage     = "https://github.com/PlacidoLv/LvBrowScrollView"
s.license      = "MIT"
s.author       = { "PlacidoLv" => "327853338@qq.com" }
s.platform     = :ios
s.source       = { :git => "https://github.com/PlacidoLv/LvBrowScrollView.git", :tag => "0.0.1",:commit => "55d17a1056b1d6f3556b493164aa04e861562db0" }
s.source_files  = "LvBrowseImageView/{*.h,*.m}"
s.requires_arc = true
s.dependency  'SDWebImage', '~> 3.7.5'

end
