//
//  ListingInteractor.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import Foundation
import NetworkKit

class ListingInteractor: PresenterToInteractorListingProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterListingProtocol?
    var items: listingConfigurations?
    
    func loadListing(url: makeURL) {
        print("Interactor receives the request from Presenter to load quotes from the server.")
        
        WebServiceHandler.callWebService(url: url, request: ListRequest()){ response, error, code in
            
            if let _ = error{
                self.presenter?.fetchListingFailure(errorCode: code)
            }
            
            guard let data = response else{
                return
            }
            do
            {
                
                let responseDetails = try JSONDecoder().decode(listingConfigurations.self, from: data)
                self.items = responseDetails
                
                if code == 200 {
                    if let itemsData = self.items {
                        self.presenter?.fetchListingSuccess(items: itemsData)
                    }
                }
                else {
                    self.presenter?.fetchListingFailure(errorCode: code)
                }
            }
            catch let err {
                print(err.localizedDescription)
                self.items = nil
                self.presenter?.fetchListingFailure(errorCode: code)
            }
            
            
        }
        
    }
    
}
