//
//  ListingConfigs.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import Foundation

// MARK: - ListingConfigs
struct ListingConfigs: Codable {
    var stateProvince: StateProvince?
    var alphaTwoCode: AlphaTwoCode?
    var domains: [String]?
    var name: String?
    var country: Country?
    var webPages: [String]?

    enum CodingKeys: String, CodingKey {
        case stateProvince = "state-province"
        case alphaTwoCode = "alpha_two_code"
        case domains, name, country
        case webPages = "web_pages"
    }
}

enum AlphaTwoCode: String, Codable {
    case pk = "PK"
}

enum Country: String, Codable {
    case pakistan = "Pakistan"
}

enum StateProvince: String, Codable {
    case balochistan = "Balochistan"
    case islamabad = "Islamabad"
    case khyberPakhtunkhwa = "Khyber Pakhtunkhwa"
    case panjab = "Panjab"
    case punjab = "Punjab"
    case sindh = "Sindh"
}

typealias listingConfigurations = [ListingConfigs]
