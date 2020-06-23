#
# Be sure to run `pod lib lint FloatingLabelTextFieldSwiftUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatingLabelTextFieldSwiftUI'
  s.version          = '4.0.0'
  s.summary          = 'A beautiful floating label textfield library written in SwiftUI.'

  s.description      = <<-DESC
 FloatingLabelTextField is a small and lightweight SwiftUI framework that allows to create beautiful and customisable floating label textfield!
                       DESC

  s.homepage         = 'https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kishanraja' => 'rajakishanrk1996@gmail.com' }
  s.source           = { :git => 'https://github.com/kishanraja/FloatingLabelTextFieldSwiftUI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/RajaKishan4'

  s.ios.deployment_target = '13.0'
  
  s.source_files = 'Sources/**/*.swift'
  
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "13.0"
  }

end
