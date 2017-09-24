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
UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var businesses: [Business]! = []
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // table view setup
        Business.searchWithTerm(term: "Thai", completion: {
            (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
            }
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

