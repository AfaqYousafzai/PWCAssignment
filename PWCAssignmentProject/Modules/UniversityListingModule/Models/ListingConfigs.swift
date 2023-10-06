//
//  ListingConfigs.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import Foundation
import Realm
import RealmSwift

typealias listingConfigurations = [ListingConfigs]

class UniversityRealm: Object {
    @objc dynamic var alphaTwoCode: String = ""
    @objc dynamic var country: String = ""
    let webPages = List<String>()
    @objc dynamic var name: String = ""
    @objc dynamic var stateProvince: String? = nil
    let domains = List<String>()

    convenience init(from university: ListingConfigs) {
        self.init()
        alphaTwoCode = university.alphaTwoCode
        country = university.country
        webPages.append(objectsIn: university.webPages)
        name = university.name
        stateProvince = university.stateProvince
        domains.append(objectsIn: university.domains)
    }
}

struct ListingConfigs: Codable {
    var alphaTwoCode: String
    var country: String
    var name: String
    var stateProvince: String?
    var webPages: [String]
    var domains: [String]

    // Add CodingKeys enum to map JSON keys to Swift property names if they don't match exactly
    enum CodingKeys: String, CodingKey {
        case alphaTwoCode = "alpha_two_code"
        case country
        case name
        case stateProvince = "state-province"
        case webPages = "web_pages"
        case domains
    }
}

extension ListingConfigs: RealmFetchable {
    typealias PersistedType = ListingConfigs
    
    static func _rlmFromObjc(_ value: Any, insideOptional: Bool) -> ListingConfigs? {
        guard let dictionary = value as? [String: Any] else {
            return nil
        }

        // Extract values from the dictionary and initialize a ListingConfigs object
        guard let alphaTwoCode = dictionary["alpha_two_code"] as? String,
              let country = dictionary["country"] as? String,
              let webPages = dictionary["web_pages"] as? [String],
              let name = dictionary["name"] as? String,
              let domains = dictionary["domains"] as? [String] else {
            return nil
        }

        let stateProvince = dictionary["state-province"] as? String

        return ListingConfigs(
            alphaTwoCode: alphaTwoCode,
            country: country,
            name: name, stateProvince: stateProvince, webPages: webPages,
            domains: domains
        )
    }
    
    var _rlmObjcValue: Any {
        // Create a dictionary representation of the ListingConfigs object
        let dictionary: [String: Any] = [
            "alpha_two_code": alphaTwoCode,
            "country": country,
            "web_pages": webPages,
            "name": name,
            "state-province": stateProvince ?? NSNull(),
            "domains": domains
        ]
        
        return dictionary
    }
    
    static func className() -> String {
        return "ListingConfigs"
    }
    
    static func _rlmDefaultValue() -> ListingConfigs {
        return ListingConfigs(alphaTwoCode: "", country: "", name: "", stateProvince: nil, webPages: [], domains: [])
    }
    
    typealias PrimaryKeyType = String
    
    var id: String {
        return alphaTwoCode // Use alphaTwoCode as the primary key
    }
    
    static var primaryKeyPropertyName: String {
        return "alphaTwoCode" // Specify the primary key property name
    }
    
    static func mapToRealmObject(_ item: ListingConfigs) -> Object? {
        // Implement the mapping from University to a Realm object.
        // Create and return a corresponding Realm object here.
        let realmObject = UniversityRealm()
        realmObject.alphaTwoCode = item.alphaTwoCode
        realmObject.country = item.country
        // Map other properties as needed.
        return realmObject
    }
    
    mutating func mapFromRealmObject(_ object: Object) {
        // Implement the mapping from a Realm object to University.
        if let realmObject = object as? UniversityRealm {
            alphaTwoCode = realmObject.alphaTwoCode
            country = realmObject.country
            // Map other properties as needed.
        }
    }
}

