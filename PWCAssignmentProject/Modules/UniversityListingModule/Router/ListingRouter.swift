//
//  ListingRouter.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit

class ListingRouter: PresenterToRouterListingProtocol {
    
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("Router creates the listing module.")
        let viewController = UniversityListingVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
}
