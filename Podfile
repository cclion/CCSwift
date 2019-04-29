# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'

target 'CCSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftyJSON', '~> 4.0' #json转换
  pod 'Alamofire', '~> 4.7' #networkTool
  pod 'FLEX', '~> 2.0' #debug
  pod 'DNSPageView' #二级联动
  pod 'SnapKit', '~> 4.0.0' #布局
  pod 'ReactiveCocoa','2.5' #RC
  pod 'Toast-Swift' #Toast
#  pod 'HandyJSON' #json转换
  pod 'HandyJSON', git: 'https://github.com/alibaba/HandyJSON.git' , branch: 'dev_for_swift5.0'
  pod 'SwiftyTimer' #Timer

  pod 'SwiftyBeaver' #彩色log
  pod 'MLeaksFinder' #检查内存泄漏
#JSONExport

  # Pods for CCSwift

  target 'CCSwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CCSwiftUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
