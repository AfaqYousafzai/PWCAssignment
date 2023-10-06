//
//  ProtocolContracts.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit
import NetworkKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewListingProtocol: AnyObject {
    func onFetchListingSuccess(items: listingConfigurations)
    func onFetchListingFailure(error: String)

    func showHUD()
    func hideHUD()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterListingProtocol: AnyObject {
    
    var view: PresenterToViewListingProtocol? { get set }
    var interactor: PresenterToInteractorListingProtocol? { get set }
    var router: PresenterToRouterListingProtocol? { get set }
    
    func numberOfRowsInSection() -> Int

    func viewDidLoad(url: makeURL)
    
    func viewDidLoadFromDb()
    
    func refresh()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorListingProtocol: AnyObject {
    
    var presenter: InteractorToPresenterListingProtocol? { get set }
    
    func loadListing(url: makeURL)
    func loadListingFromDb()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterListingProtocol: AnyObject {
    
    func fetchListingSuccess(items: listingConfigurations)
    func fetchListingFailure(errorCode: Int)
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterListingProtocol: AnyObject {
    
    static func createModule() -> UINavigationController
    
    static func createDetails(detailObject: ListingConfigs, vc: UIViewController)
}
