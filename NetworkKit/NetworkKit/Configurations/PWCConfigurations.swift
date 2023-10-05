//
//  PWCConfigurations.swift
//  NetworkKit
//
//  Created by Afaq Ahmad on 10/6/23.
//

import Foundation

// Written down in inof.plist

let kAppConfiguration = "AppConfiguration"
let kBuildEnvironment = "BuildEnvironment"
let kConfiguration = "Configuration"

// Wirtten down in Configurations.plist file

let kemptyString = ""
let kConfigurations = "Configurations"
let kPlist = "plist"
let kenvironment = "Environment"

let kBaseUrl = "BaseURL"

class PWCConfigurations: NSObject {
    
    class func getCloudSettings () -> [String: Any] {
        
        if let kCloudSettings = Bundle(identifier: "com.DemoLab.GoogleMapPOC.NetworkKit")?.path(forResource: kConfigurations, ofType: kPlist) {
            
            if let dic = NSDictionary(contentsOfFile: kCloudSettings) as? [String: Any] {
                let configurationName = Bundle(identifier: "com.DemoLab.GoogleMapPOC.PWCAssignmentProject")?.configuration
                if let tenantConfigurations = dic[configurationName!] as? [String: Any] {
                    return tenantConfigurations
                }
            }
        }
        return [String: Any]()
    }
    
    class func getBuildEnvironmentSettings () -> [String: Any] {
        
        let cloudConfigurations = getCloudSettings()
        let buildEnvironment = Bundle(identifier: "com.DemoLab.GoogleMapPOC.PWCAssignmentProject")?.buildEnvironment
        if let buildEnvironments = cloudConfigurations[kenvironment] as? [String:Any] {
            if let currentEnviromentSettings = buildEnvironments[buildEnvironment!] as? [String:Any] {
                return currentEnviromentSettings
            }
        }
        return [String: Any]()
    }
    
    
    class func getBaseURL() -> String {
        
        let currentBuildEnvironmentConfigurations = getBuildEnvironmentSettings()
        if let buildSettings = currentBuildEnvironmentConfigurations[kBaseUrl] as? String
        {
            return buildSettings
        }
        return ""
    }
    
}

extension Bundle {
    
    var buildEnvironment: String? {
        
        if let appConfiguration = object(forInfoDictionaryKey: kAppConfiguration) as? [String:Any] {
            return appConfiguration[kBuildEnvironment] as? String
        }
        return ""
    }
    var configuration: String? {
        
        if let appConfiguration = object(forInfoDictionaryKey: kAppConfiguration) as? [String:Any] {
            return appConfiguration[kConfiguration] as? String
        }
        return ""
    }
    
}
