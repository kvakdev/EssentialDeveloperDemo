# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


# ignore all warnings from all pods
inhibit_all_warnings!
# Available
def available_pods
  networking_pods
  helpers_pods
end
# Networking
def networking_pods
  pod 'Alamofire', '~> 4.8.2'
  pod 'Reachability', '~> 3.2'
  pod 'SDWebImage', '~> 5.0.6'
end
# Helpers
def helpers_pods
  use_frameworks!
  pod 'Moya', '~> 13.0.1'
  pod 'RxSwift', '~> 5.0.1'
  pod 'RxCocoa', '~> 5.0.1'
  pod 'SwiftLint'
  pod 'PromiseKit', '~> 6.10.0'
  pod 'RxBlocking', '~> 5.1.1'
end


target 'EssentialDeveloperDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  available_pods
  # Pods for EssentialDeveloperDemo

  target 'EssentialDeveloperDemoTests' do
        inherit! :search_paths
	available_pods
  end

end
