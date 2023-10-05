//
//  UniversityListingVC.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit
import PKHUD
import NetworkKit

class UniversityListingVC: UIViewController {
    
    @IBOutlet weak var universityTableView: UITableView!
    
    // MARK: - Properties
    var presenter: ViewToPresenterListingProtocol?
    var listingConfigs: listingConfigurations?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupController()
        setupUI()
        initialSettings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func initialSettings() {
        if listingConfigs == nil {
            presenter?.viewDidLoad(url: .getList)
        }
    }
    
    // MARK: - Actions
    @objc func refresh() {
        presenter?.refresh()
    }

    
}

extension UniversityListingVC: PresenterToViewListingProtocol{
    
    func onFetchListingSuccess(items: listingConfigurations) {
        print("View receives the response from Presenter and updates itself.")
        listingConfigs = items
        self.universityTableView.reloadData()
    }
    
    func onFetchListingFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.refreshControl.endRefreshing()
        PWCAssignmentProjectGeneralElements.showAlertWithMessage("\(error)", sender: nil)
    }
    
    func showHUD() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideHUD() {
        HUD.hide()
    }
    
}

extension UniversityListingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listingConfigs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UniversityListingTableViewCell.self), for: indexPath) as? UniversityListingTableViewCell else {
            preconditionFailure()
        }
        if let list = listingConfigs?[indexPath.item] {
            cell.set(content: list)
        }
        return cell
    }
}

extension UniversityListingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


// MARK: - UI Setup
extension UniversityListingVC {
    func setupUI() {
        universityTableView.addSubview(refreshControl)
    }
    
    func setupController() {
        
        let presenter: ViewToPresenterListingProtocol & InteractorToPresenterListingProtocol = ListPresenter()
        
        self.presenter = presenter
        self.presenter?.router = ListingRouter()
        self.presenter?.view = self
        self.presenter?.interactor = ListingInteractor()
        self.presenter?.interactor?.presenter = presenter
    }
}
