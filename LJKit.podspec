#
# Be sure to run `pod lib lint LJKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LJKit'
  s.version          = '0.1.2'
  s.summary          = '方便自己以后开发的工具类'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/185704108@qq.com/LJKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liujing' => 'liujingguoke@163.com' }
  s.source           = { :git => 'https://github.com/liujingCode/LJKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'LJKit/Classes/**/*'
  category.public_header_files = 'LJKit/Classes/**/*'
  
  s.subspec 'Category' do |category|
      category.source_files = 'LJKit/Classes/Category/**/*'
      category.public_header_files = 'LJKit/Classes/Category/**/*.h'
      category.frameworks = 'UIKit'
  end
  
  # s.resource_bundles = {
  #   'LJKit' => ['LJKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking'
    s.dependency 'SDWebImage'
    s.dependency 'MJRefresh'
    s.dependency 'Masonry'
    s.dependency 'MBProgressHUD'
    s.dependency 'IQKeyboardManager'
    s.dependency 'SDCycleScrollView'
    s.dependency 'TZImagePickerController'
end
