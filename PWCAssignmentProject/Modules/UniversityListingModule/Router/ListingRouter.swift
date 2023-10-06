//
//  ListingRouter.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit

class ListingRouter: PresenterToRouterListingProtocol {
    
    private let navigationController: UINavigationController
        
        // Dependency injection to provide the navigation controller
        init(navigationController: UINavigationController) {
            self.navigationController = navigationController
        }
    
    
    // MARK: Static methods
    static func createModule() -> UINavigationController {
        
        print("Router creates the listing module.")
        let viewController = UniversityListingVC()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    static func createDetails(detailObject: ListingConfigs, vc: UIViewController) {
        // Ensure detailObject contains the necessary data
        guard let university = detailObject as? ListingConfigs else {
            return
        }
        
        // Create and push the detail view controller
        let detailViewController = UniversityDetailBuilder.createModule(with: university)
        detailViewController.delegate = vc as? UniversityDetailViewControllerDelegate
        vc.present(detailViewController, animated: true)
    }

    
}
