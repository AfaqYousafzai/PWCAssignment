//
//  UniversityDetailViewController.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/6/23.
//

import UIKit

protocol UniversityDetailView: AnyObject {
    func populateUniversityName(_ name: String)
    func populateUniversityDomain(_ state: String)
    func populateUniversityWebPage(_ webPage: String)
}

protocol UniversityDetailViewControllerDelegate: AnyObject {
    func universityDetailViewControllerDidRequestRefresh()
}

class UniversityDetailViewController: UIViewController, UniversityDetailView {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var domainLabel: UILabel!
    @IBOutlet private var webPageLabel: UILabel!
    
    var presenter: UniversityDetailPresenter!
    weak var delegate: UniversityDetailViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    func populateUniversityName(_ name: String) {
        nameLabel.isHidden = false
        nameLabel.text = name
    }

    func populateUniversityDomain(_ state: String) {
        domainLabel.isHidden = false
        domainLabel.text = state
    }
    func populateUniversityWebPage(_ webPage: String) {
        webPageLabel.isHidden = false
        webPageLabel.text = webPage
    }
    
    @IBAction func refreshListingController() {
        delegate?.universityDetailViewControllerDidRequestRefresh()
    }
}
