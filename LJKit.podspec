
Pod::Spec.new do |spec|
  spec.name         = 'LJKit'
  spec.version      = '0.1.6'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/liujingCode'
  spec.authors      = { 'liujing' => 'liujingguoke@163.com' }
  spec.summary         = '方便自己以后开发的工具类'
  spec.source       = { :git => 'https://github.com/liujingCode/LJKit.git', :tag => spec.version.to_s }
  spec.ios.deployment_target = '9.0'
  
  spec.source_files = 'Example/LJKit/LJKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LJKit' => ['LJKit/Assets/*.png']
  # }
  spec.framework    = 'UIKit'
  
  
  # 分类
  spec.subspec 'Category' do |category|
      category.framework    = 'UIKit','Foundation'
      category.source_files = 'Example/LJKit/LJKit/Classes/Category/**/*'
  end
  
  # 自定义UI
  spec.subspec 'CustomUI' do |customUI|
    customUI.framework    = 'UIKit'
    customUI.source_files = 'Example/LJKit/LJKit/Classes/CustomUI/**/*'
  end
  
  # 调试工具
  spec.subspec 'Debug' do |debug|
    debug.framework    = 'UIKit','Foundation'
    debug.source_files = 'Example/LJKit/LJKit/Classes/Debug/**/*'
  end
  
  # 工具类
  spec.subspec 'Utils' do |utils|
    utils.source_files = 'Example/LJKit/LJKit/Classes/Utils/**/*'
    
    # 网络
    utils.subspec 'HttpManager' do |httpManager|
      httpManager.source_files = 'Example/LJKit/LJKit/Classes/Utils/LJHttpManager/**/*'
      httpManager.dependency 'AFNetworking'
    end
    
    # 拍照或相册
    utils.subspec 'ImagePickerManager' do |imagePickerManager|
        imagePickerManager.source_files = 'Example/LJKit/LJKit/Classes/Utils/LJImagePickerManager/**/*'
        imagePickerManager.dependency 'TZImagePickerController'
    end
    
    # 定位
    utils.subspec 'LocationManager' do |locationManager|
        locationManager.source_files = 'Example/LJKit/LJKit/Classes/Utils/LJLocationManager/**/*'
    end
    
    # 换肤
    utils.subspec 'ThemeManager' do |themeManager|
        themeManager.source_files = 'Example/LJKit/LJKit/Classes/Utils/LJThemeManager/**/*'
    end
  end
  
  
  spec.dependency 'SDWebImage'
  spec.dependency 'MJRefresh'
  spec.dependency 'Masonry'
  spec.dependency 'MBProgressHUD'
  spec.dependency 'IQKeyboardManager'
  spec.dependency 'SDCycleScrollView'
  spec.dependency 'TZImagePickerController'
end
