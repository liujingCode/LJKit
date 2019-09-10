
Pod::Spec.new do |spec|
  spec.name         = 'LJKit'
  spec.version      = '0.1.1'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/liujingCode'
  spec.authors      = { 'liujing' => 'liujingguoke@163.com' }
  spec.summary         = '方便自己以后开发的工具类'
  # spec.source       = { :git => 'https://github.com/liujingCode/LJKit.git', :tag => s.version.to_s }
  spec.source       = { :git => 'https://github.com/liujingCode/LJKit.git'}
  spec.ios.deployment_target = '9.0'
  
  spec.source_files = 'LJKit/Classes/**/*'
  spec.framework    = 'UIKit'
  
  spec.subspec 'Category' do |category|
      category.framework    = 'UIKit','Fundation'
      category.source_files = 'LJKit/Classes/Category/**/*'
  end
  
  spec.dependency 'AFNetworking'
  spec.dependency 'SDWebImage'
  spec.dependency 'MJRefresh'
  spec.dependency 'Masonry'
  spec.dependency 'MBProgressHUD'
  spec.dependency 'IQKeyboardManager'
  spec.dependency 'SDCycleScrollView'
  spec.dependency 'TZImagePickerController'
end
