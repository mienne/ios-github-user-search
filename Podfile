platform :ios, '13.0'

inhibit_all_warnings!
use_frameworks!

target 'GithubUserSearch' do
  # UI

  pod 'SnapKit'
  pod 'BonMot'

  # Architecture
  
  pod 'RIBs', git: 'https://github.com/uber/RIBs.git', branch: 'master', submodules: true
  pod 'ReactorKit', git: 'https://github.com/ReactorKit/ReactorKit', branch: 'master', submodules: true
    
  # Networking
  
  pod 'Moya'
  pod 'Moya/RxSwift' 
  pod 'Kingfisher'
  
  # Rx
  
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRelay'
  pod 'RxDataSources'
  pod 'RxOptional'
  pod 'RxSwiftExt'
  pod 'RxGesture'
  
  # Misc.

  pod 'SwiftLint'
  pod 'R.swift'
  pod 'CocoaLumberjack/Swift'

  target 'GithubUserSearchTests' do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
    pod 'RxBlocking'
  end

end
