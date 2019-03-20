#
#  Be sure to run `pod spec lint STRService.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "STRService"
  spec.version      = "0.0.1"
  spec.summary      = "my"
  spec.homepage     = "http://www.tma.com"
  spec.license      = "TMA"
  spec.author             = { "TMA" => "tma@tma.com.vn" }
  spec.source       = { :git => ".", :tag => spec.version }
  spec.source_files  = "STRService/*/*"
  
  spec.dependency "Alamofire", "~> 4.8.1"
  spec.dependency "ObjectMapper", "~> 3.4.2"
  spec.dependency "AlamofireObjectMapper", "~> 5.2"
  
end
