//
//  ListingInteractor.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import Foundation
import NetworkKit
import Realm
import RealmSwift

class ListingInteractor: PresenterToInteractorListingProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterListingProtocol?
    var items: [ListingConfigs] = []
    
    func loadListing(url: makeURL) {
        print("Interactor receives the request from Presenter to load universities from the server.")
        
        WebServiceHandler.callWebService(url: url, request: ListRequest()){ response, error, code in
            
            if let _ = error{
                self.presenter?.fetchListingFailure(errorCode: code)
            }
            
            guard let data = response else{
                return
            }
            do
            {
                let universities = try JSONDecoder().decode([ListingConfigs].self, from: data)
                self.items = universities
                
                if code == 200 {
                    if self.items.count > 0 {
                        // Initialize a Realm instance
                        let realm = try! Realm()
                        
                        // Write universities to Realm
                        try! realm.write {
                            for university in universities {
                                realm.add(UniversityRealm(from: university))
                            }
                        }
                        self.presenter?.fetchListingSuccess(items: self.items)
                    }
                }
                else {
                    self.presenter?.fetchListingFailure(errorCode: code)
                }
                
            }
            catch let err {
                print(err.localizedDescription)
                self.items.removeAll()
                self.presenter?.fetchListingFailure(errorCode: code)
            }
            
            
        }
        
    }
    
    
    func loadListingFromDb() {
        print("Interactor receives the request from Presenter to load universities from the server.")
        do
        {
            let realm = try! Realm()
            let universityRealmObjects = realm.objects(UniversityRealm.self)

            for universityRealm in universityRealmObjects {
                // Map each UniversityRealm object to a ListingConfigs object
                let listingConfigsItems = ListingConfigs(
                    alphaTwoCode: universityRealm.alphaTwoCode,
                    country: universityRealm.country,
                    name: universityRealm.name,
                    stateProvince: universityRealm.stateProvince,
                    webPages: Array(universityRealm.webPages),
                    domains: Array(universityRealm.domains)
                )

                // Append the ListingConfigs object to the array
                self.items.append(listingConfigsItems)
            }
            self.presenter?.fetchListingSuccess(items: items)
        }
        catch let err {
            print(err.localizedDescription)
            self.items.removeAll()
//            self.presenter?.fetchListingFailure(errorCode: )
        }
    }
}
