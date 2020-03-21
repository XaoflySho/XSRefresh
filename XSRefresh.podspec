#
#  Be sure to run `pod spec lint XSRefresh.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name          = "XSRefresh"
  spec.version       = "0.0.1"
  spec.license       = { :type => "MIT", :file => "LICENSE" }
  
  spec.homepage      = "https://github.com/XaoflySho/XSRefresh"
  spec.author        = { "Xaofly Sho" => "shaoxiaof@hotmail.com" }
  spec.summary       = "An easy way to use pull-to-refresh, MJRefresh with swift version."
  
  spec.source        = { :git => "https://github.com/XaoflySho/XSRefresh.git", :tag => "#{spec.version}" }
  spec.swift_version = '5.0'

  spec.ios.deployment_target  = '9.0'
  
  spec.source_files  = "XSRefresh/**/*.swift"
  spec.resource      = "XSRefresh/**/*.bundle"

end
