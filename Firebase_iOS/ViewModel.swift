//
//  ViewModel.swift
//  Sample_Firebase
//
//  Created by Ponraj, Rooban (Cognizant) on 05/07/21.
//

import Foundation
import FirebaseFirestore

class CityViewModel {
    var loadWithDataSource: (() -> ())?
    var loadWithError: (() -> ())?
    
    var cityListModel : [CityListModel]?
    
    func getCityList() {
        // Get the menu option based on the access level
        let db = Firestore.firestore()
        db.collection("cityList").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.loadWithError?()
            } else {
                
                let models = querySnapshot?.documents.compactMap { (document) -> CityListModel? in
                    if let model = CityListModel(dictionary: document.data()) {
                        return model
                    } else {
                        //Error Parsing Document
                        return nil
                    }
                }
                
                if let models = models {
                    self.cityListModel = models
                    self.loadWithDataSource?()
                } else {
                    self.loadWithError?()
                }
            }
        }
    }
}
