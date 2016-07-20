#
# Be sure to run `pod lib lint DRYTestUtilities.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DRYTestUtilities"
  s.version          = "1.0.0"
  s.summary          = "AppFoundry test utilities"
  s.homepage         = "https://github.com/appfoundry/DRYTestUtilities"
  s.license          = 'MIT'
  s.author           = { "Michael Seghers" => "mike@appfoundry.be" }
  s.source           = { :git => "https://github.com/appfoundry/DRYTestUtilities.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.frameworks = 'XCTest'
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }

  s.subspec 'Core' do |c|
    c.source_files = 'Pod/Classes/Core/*'
    c.dependency 'DRYUtilities'
  end

  s.subspec 'OCMockitoSupport' do |ocms|
    ocms.dependency 'DRYTestUtilities/Core'
    ocms.dependency 'OCMockito'
    ocms.source_files = 'Pod/Classes/OCMockitoSupport/*'
  end
end
