//
//  UniversityDetailPresenterImplementation.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/6/23.
//

import Foundation

protocol UniversityDetailPresenter {
    func viewDidLoad()
}

class UniversityDetailPresenterImplementation: UniversityDetailPresenter {
    weak var view: UniversityDetailView?
    var interactor: UniversityDetailInteractor
    var university: ListingConfigs

    init(view: UniversityDetailView, interactor: UniversityDetailInteractor, university: ListingConfigs) {
        self.view = view
        self.interactor = interactor
        self.university = university
    }

    func viewDidLoad() {
        view?.populateUniversityName(university.name)
        if let webPage = university.domains.first {
            view?.populateUniversityDomain(webPage)
        }
        if let webPage = university.webPages.first {
            view?.populateUniversityWebPage(webPage)
        }
    }
}
