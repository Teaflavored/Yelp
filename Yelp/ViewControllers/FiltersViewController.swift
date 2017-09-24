//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Auster Chen on 9/23/17.
//  Copyright © 2017 Auster Chen. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func onSave(viewController: FiltersViewController)
}

class FiltersViewController: UIViewController,
UITableViewDataSource,
UITableViewDelegate,
DealsCellDelegate {

    @IBOutlet weak var filterTable: UITableView!
    weak var delegate: FilterDelegate?
    lazy var onSaveFilters = {
        [unowned self]
        () -> Void in
        SearchSettings.instance.updateSort(self.sort)
        SearchSettings.instance.updateSearchRadius(self.searchRadiusInMeters)
        SearchSettings.instance.updateDealsSwitch(self.hasDeals)
        SearchSettings.instance.updateCategories(self.selectedCategories)
        self.delegate?.onSave(viewController: self)
    }

    var selectedCategories: [String]?
    var searchRadiusInMeters: Int?
    var hasDeals: Bool = false
    var sort: YelpSortMode = YelpSortMode.bestMatched

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

    @IBAction func saveFilters(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: onSaveFilters)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)

        switch indexPath.section {
        case 1:
            let distanceCell = cell as! DistanceCell
            searchRadiusInMeters = distanceCell.distanceValue
            filterTable.reloadData()
        case 2:
            let sortCell = cell as! SortCell
            let sortValue = sortCell.sortValue
            sort = sortValue!
            filterTable.reloadData()
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = getCellWithIdentifier("dealsCell") as! DealsCell
            cell.delegate = self
            cell.dealSwitch.isOn = hasDeals
            return cell
        case 1:
            let cell = getCellWithIdentifier("distanceCell") as! DistanceCell
            let distanceData = SearchSettings.instance.searchRadiusesMap
            let distanceDatum = distanceData[indexPath.row]
            let name = distanceDatum["name"] as! String
            let value = distanceDatum["value"] as! Int
            
            cell.distanceLabel.text = name
            cell.distanceValue = value

            if let unwrappedSearchRadius = searchRadiusInMeters {
                if value == unwrappedSearchRadius {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            } else {
                cell.accessoryType = .none
            }

            return cell
        case 2:
            let cell = getCellWithIdentifier("sortCell") as! SortCell
            let sortData = SearchSettings.instance.sortValuesMap
            let sortDatum = sortData[indexPath.row]
            let name = sortDatum["name"] as! String
            let sortValue = sortDatum["value"] as! YelpSortMode

            cell.sortLabel.text = name
            cell.sortValue = sortValue

            if sortValue == sort {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }

            return cell
        default:
            return UITableViewCell()
        }
    }

    func dealsSwitchCellDidToggle(cell: DealsCell, newValue: Bool) {
        hasDeals = newValue
    }

    fileprivate func getCellWithIdentifier(_ identifier: String) -> UITableViewCell {
        guard let cell = filterTable.dequeueReusableCell(withIdentifier: identifier) else {
            return UITableViewCell()
        }

        return cell
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
