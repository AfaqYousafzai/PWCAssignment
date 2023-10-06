//
//  UniversityDetailRouterImplementation.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/6/23.
//

import UIKit

protocol UniversityDetailRouter {
    
}

class UniversityDetailRouterImplementation: UniversityDetailRouter {
    weak var viewController: UniversityDetailViewController?

    init(viewController: UniversityDetailViewController) {
        self.viewController = viewController
    }
}

class UniversityDetailBuilder {
    static func createModule(with university: ListingConfigs) -> UniversityDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "UniversityDetailViewController") as! UniversityDetailViewController
        let interactor = UniversityDetailInteractorImplementation()
        let router = UniversityDetailRouterImplementation(viewController: view)
        let presenter = UniversityDetailPresenterImplementation(view: view, interactor: interactor, university: university)

        view.presenter = presenter
        presenter.view = view

        return view
    }
}

