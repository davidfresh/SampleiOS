//
//  AppViewController.swift
//  ListApp
//
//  Created by DavidFresh on 3/12/18.
//  Copyright © 2018 davidfresh. All rights reserved.
//

import UIKit

class AppViewController: UIViewController {
    // MARK: - Injections
    internal var networkClient = NetworkClient.shared
    
    
    // MARK: - Instance Properties
    internal var itemApps: [ItemApp] = []
    
    
    // MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(loadProducts),
                                     for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }
    
    @objc internal func loadProducts() {
        tableView.refreshControl?.beginRefreshing()
        networkClient.getProducts (
            
            success: { [weak self] items in
                guard let strongSelf = self else { return }
                strongSelf.itemApps = items
                strongSelf.tableView.reloadData()
                strongSelf.tableView.refreshControl?.endRefreshing()
                
                
            }, failure: { [weak self] error in
                print("tems download failed: \(error)")
                guard let strongSelf = self else { return }
                strongSelf.tableView.refreshControl?.endRefreshing()
        })
    }
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts()
        // Do any additional setup after loading the view.
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let selectedItem = tableView.indexPathsForSelectedRows
            else { return }
        selectedItem.forEach { tableView.deselectRow(
            at: $0, animated: false)
        }
    }
    
    // MARK: - Segue
    public override func prepare(for segue: UIStoryboardSegue,
                                 sender: Any?) {
        guard let viewController = segue.destination
            as? DetailAppViewController else { return }
        let indexPath = tableView.indexPathsForSelectedRows!.first!
        let apps = itemApps[indexPath.row]
        viewController.productViewModel = AppViewModel(app: apps)
    }

    

}

// MARK: - UICollectionViewDataSource
extension AppViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "AppCell"
        
        let items = itemApps[indexPath.row]
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath) as! AppTableViewCell
        cell.lblNameApp.text = items.title
        cell.lblPriceApp.text = items.priceApp
        cell.appImageView.rw_setImage(url: items.imageURL)
        return cell
    }
    

}
