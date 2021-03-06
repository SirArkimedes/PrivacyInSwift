#
# Be sure to run `pod lib lint PrivacyInSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PrivacyInSwift'
  s.version          = '1.0.0'
  s.summary          = 'A Swift wrapper around the Privacy.com API.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A wrapper around the privacy.com API written in Swift.
                       DESC

  s.homepage         = 'https://github.com/SirArkimedes/PrivacyInSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Robinson' => 'sirarkimedes@gmail.com' }
  s.source           = { :git => 'https://github.com/SirArkimedes/PrivacyInSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/SirArkimedes'

  s.ios.deployment_target = '10.0'
  s.swift_version         = '5.0'

  s.source_files = 'PrivacyInSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PrivacyInSwift' => ['PrivacyInSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'Alamofire', '~> 5.1'
   s.dependency 'SwiftyJSON', '~> 4.0'
   s.dependency 'SwiftyJSONModel', '~> 2.3.0'
end
