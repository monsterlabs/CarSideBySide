#
# Be sure to run `pod spec lint MBFaker.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "MBFaker"
  s.version      = "0.0.1"
  s.summary      = "Objective-C fake data generator."
  s.homepage     = "https://github.com/bananita/MBFaker"
  s.screenshots  = "https://github.com/bananita/MBFaker/blob/master/Screenshots/ios.png"
  s.license      = 'This code is free to use under the terms of the MIT license'
  s.author       = { "Michał Banasiak" => "m.banasiak@aol.pl" }
  s.source       = { :git => "git://github.com/bananita/MBFaker.git", :branch => "master" }
  s.platform     = :ios, '5.0'
  s.source_files = 'MBFaker'
  s.resources    = 'MBFaker/Locales'
  s.preserve_paths    = 'MBFaker/Locales'
  s.requires_arc = true
  s.dependency   'LibYAML', '~> 0.1.4'
end
