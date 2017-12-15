
platform :ios, '9.0'
use_frameworks!

target 'Fiskas' do
    
    pod 'Alamofire', '~> 4.5'
    pod ‘SWRevealViewController’
    
end

post_install do |installer|
    myTargets = ['Alamofire']
    
    installer.pods_project.targets.each do |target|
        if myTargets.include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
