# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

workspace 'PWCAssignmentProject.xworkspace'
project 'PWCAssignmentProject.xcodeproj'

target 'PWCAssignmentProject' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

    # Pods for PWCAssignmentProject

    pod 'PKHUD'
    pod 'Alamofire'
    pod 'RealmSwift'


  target 'PWCAssignmentProjectTests' do
    
    pod 'RealmSwift'
    inherit! :search_paths
    # Pods for testing
  end

  target 'PWCAssignmentProjectUITests' do
    # Pods for testing
  end

end

target 'NetworkKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PWCAssignmentProject
  
  project 'NetworkKit/NetworkKit.xcodeproj'
  pod 'PKHUD'
  pod 'Alamofire'
  pod 'RealmSwift'
  inherit! :search_paths
end



