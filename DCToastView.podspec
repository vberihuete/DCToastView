
Pod::Spec.new do |s|
  s.name             = 'DCToastView'
  s.version          = '0.1.0'
  s.summary          = 'A Toast View made in swift using auto layout and stack views'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

  This is part of the DC UI libraries to handle a simple Stack view and Auto layout friendly Toast View
  
                       DESC

  s.homepage         = 'https://github.com/vberihuete/DCToastView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'vberihuete' => 'vberihuete@gmail.com' }
  s.source           = { :git => 'https://github.com/vberihuete/DCToastView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/vberihuete'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'DCToastView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DCToastView' => ['DCToastView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
