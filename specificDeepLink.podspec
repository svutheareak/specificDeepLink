#
# Be sure to run `pod lib lint specificDeepLink.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'specificDeepLink'
  s.version          = '0.1.2'
  s.summary          = 'specificDeepLink is the link that allow user to passing and return the value with PBApplication.'
  s.swift_version    = '5'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'specificDeepLink is an awsome pod to process connection with PBApplication. You can pass the value and connect to our App and return value back after it process done.'.
                       DESC

  s.homepage         = 'https://github.com/svutheareak/specificDeepLink.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'svutheareak' => 'svutheareak@gmail.com' }
  s.source           = { :git => 'https://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@github.com/svutheareak/specificDeepLink.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/sam-vutheareak-bb174719a'

  s.ios.deployment_target = '12.0'

#  s.source_files = 'specificDeepLink/Classes/**/*'
  
  # s.resource_bundles = {
  #   'specificDeepLink' => ['specificDeepLink/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
