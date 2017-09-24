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
        print("HI")
        self.delegate?.onSave(viewController: self)
    }

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = getCellWithIdentifier("dealsCell") as! DealsCell
            cell.delegate = self
            cell.dealSwitch.isOn = SearchSettings.instance.getDealsValue()

            return cell
        default:
            return UITableViewCell()
        }
    }

    func dealsSwitchCellDidToggle(cell: DealsCell, newValue: Bool) {
        SearchSettings.instance.updateDealsSwitch(newValue)
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
