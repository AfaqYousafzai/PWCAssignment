//
//  UniversityListingPresenter.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import Foundation
import NetworkKit

class ListPresenter: ViewToPresenterListingProtocol {
    
    // MARK: Properties
    weak var view: PresenterToViewListingProtocol?
    var interactor: PresenterToInteractorListingProtocol?
    var router: PresenterToRouterListingProtocol?
    
    var counter : Int?
    
    // MARK: Inputs from view
    func viewDidLoad(url: makeURL) {
        print("Presenter is being notified that the View was loaded.")
        view?.showHUD()
        interactor?.loadListing(url: url)
    }
    
    func refresh() {
        print("Presenter is being notified that the View was refreshed.")
    }
    
    func numberOfRowsInSection() -> Int {
        guard let countItems = self.counter else {
            return 0
        }
        
        return countItems
    }
    
}

// MARK: - Outputs to view
extension ListPresenter: InteractorToPresenterListingProtocol {
    
    func fetchListingSuccess(items: listingConfigurations) {
        print("Presenter receives the result from Interactor after it's done its job.")
        counter = items.count
        view?.hideHUD()
        view?.onFetchListingSuccess(items: items)
    }
    
    func fetchListingFailure(errorCode: Int) {
        print("Presenter receives the result from Interactor after it's done its job.")
        view?.hideHUD()
        view?.onFetchListingFailure(error: "Couldn't fetch quotes: \(errorCode)")
    }
    
    
}
