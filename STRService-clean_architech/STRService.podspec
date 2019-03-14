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
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

 
  spec.license      = "TMA"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  

  spec.author             = { "Quyen Nguyen" => "ntquyen1@tma.com.vn" }
  # Or just: spec.author    = "Quyen Nguyen"
  # spec.authors            = { "Quyen Nguyen" => "ntquyen1@tma.com.vn" }
  # spec.social_media_url   = "https://twitter.com/Quyen Nguyen"



  # spec.platform     = :ios
  # spec.platform     = :ios, "9.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  

  spec.source       = { :git => "https://github.com/QuyenNguyenThe/STRService", :tag => spec.version }



  spec.source_files  = "STRService/*/*"
  #spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  
  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


 
  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"

 
  # spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  
  spec.dependency "Alamofire", "~> 4.8.0"
  spec.dependency "ObjectMapper", "~> 3.4.2"
end
