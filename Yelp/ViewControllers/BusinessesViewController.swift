//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Auster Chen on 9/19/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessesViewController: UIViewController,
    UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate,
FilterDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    fileprivate var businesses: [Business]! = []
    fileprivate var searchBar: UISearchBar!
    fileprivate lazy var businessCompletion = {
        [unowned self]
        (businesses: [Business]?, error: Error?) -> Void in
        
        self.businesses = businesses
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Restaurants"
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        searchWithSearchSettings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchSettings.instance.updateSearchTerm(searchText)
        searchWithSearchSettings()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "businessCell") as? BusinessTableViewCell else {
            return UITableViewCell()
        }
    tableCell.updateWithBusiness(businesses[indexPath.row])

        return tableCell
    }
    
    func onSave(viewController: FiltersViewController) {
        searchWithSearchSettings()
    }

    private func searchWithSearchSettings() -> Void {
        Business.searchWithTerm(
            term: SearchSettings.instance.getSearchTerm(),
            sort: SearchSettings.instance.getSort(),
            categories: SearchSettings.instance.getCategories(),
            deals: SearchSettings.instance.getDealsValue(),
            completion: businessCompletion
        )
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UINavigationController
        let viewController = destination.viewControllers[0] as! FiltersViewController
        viewController.delegate = self
        viewController.hasDeals = SearchSettings.instance.getDealsValue()
        viewController.searchRadiusInMeters = SearchSettings.instance.getSearchRadius()
        viewController.sort = SearchSettings.instance.getSort()
    }
}

