//
//  ViewController.swift
//  Firebase_iOS
//
//  Created by Ponraj, Rooban (Cognizant) on 05/07/21.
//

import UIKit

class CityListView: UIViewController {
    @IBOutlet var tableView : UITableView!
    var cityViewModel: CityViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        initViewModel()
    }

    private func initViewModel() {
        cityViewModel = CityViewModel()
        
        // Handle error response
        cityViewModel?.loadWithError = {
            //self.stopLoading()
            self.tableView.isHidden = true
        }
        // Handle success response
        cityViewModel?.loadWithDataSource = {
            //self.stopLoading()
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
        //Make service call to fetch city list
        cityViewModel?.getCityList()
    }
}

extension CityListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel?.cityListModel?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell") as? CityListCell else {
            return UITableViewCell()
        }
        
        if let cityModel = cityViewModel?.cityListModel?[indexPath.row] {
            cell.cityModel = cityModel
        }
        
        return cell
    }
}

