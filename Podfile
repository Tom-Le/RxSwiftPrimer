platform :ios, '11.0'
use_frameworks!

def project_pods
  pod 'RxSwift', '~> 4.4.0'
  pod 'RxCocoa', '~> 4.4.0'
  pod 'RxSwiftExt', '~> 3.4.0'
end

target 'RxSwiftPrimer' do
  project_pods

  target 'RxSwiftPrimerTests' do
    inherit! :search_paths
    pod 'RxTest', '~> 4.4.0'
  end
end

target 'RxSwiftPrimer (Mock)' do
  project_pods
end

