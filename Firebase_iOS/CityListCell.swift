//
//  CityListCell.swift
//  Firebase_iOS
//
//  Created by Ponraj, Rooban (Cognizant) on 05/07/21.
//

import UIKit

class CityListCell: UITableViewCell {

    var cityModel: CityModel? {
        didSet {
            loadData()
        }
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadData() {
        if let city = cityModel {
            self.nameLabel.text = city.name
            self.stateLabel.text = city.state
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
