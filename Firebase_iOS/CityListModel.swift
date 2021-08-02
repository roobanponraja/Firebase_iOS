//
//  CityListModel.swift
//  Sample_Firebase
//
//  Created by Ponraj, Rooban (Cognizant) on 05/07/21.
//

import Foundation

struct CityModel {
    var name: String?
    var state: String?
}

extension CityModel {
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
              let state = dictionary["state"] as? String
            else { return nil }
        self.init(name: name, state: state)
    }
}
