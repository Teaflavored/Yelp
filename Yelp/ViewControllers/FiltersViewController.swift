//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Auster Chen on 9/23/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController,
UITableViewDataSource,
UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissFilter(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection 
        section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return SearchSettings.instance.searchRadiusesMap.count
        case 2:
            return SearchSettings.instance.sortValuesMap.count
        case 3:
            return SearchSettings.instance.categories.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Distance"
        case 2:
            return "Sort"
        case 3:
            return "Category"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
