//
//  ViewModel.swift
//  Firebase_iOS
//
//  Created by Ponraj, Rooban on 05/07/21.
//

import Foundation
import FirebaseFirestore

class CityViewModel {
    var loadWithDataSource: (() -> ())?
    var loadWithError: (() -> ())?
    
    var cityListModel : [CityModel]?
    
    func addNewCity() {
        let dic : [String: String] = ["name": "Mumbai", "state": "Maharashtra"]
        let db = Firestore.firestore()
        _ = db.collection("cityList").addDocument(data: dic) { err in
            if err != nil {
                self.loadWithError?()
            } else {
                self.loadWithDataSource?()
            }
        }
    }
    
    func updateCity() {
        let dic : [String: String] = ["name": "Bombay", "state": "Maharashtra"]
        let db = Firestore.firestore()
        db.collection("cityList").document("KjhxTtFDStraY61eDFPV").setData(dic) { err in
            if err != nil {
                self.loadWithError?()
            } else {
                self.loadWithDataSource?()
            }
        }
    }
    
    func updateCityField() {
        let db = Firestore.firestore()
        let cityRef = db.collection("cityList").document("KjhxTtFDStraY61eDFPV")

        cityRef.updateData([
            "name": "Mumbai"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func deleteBill() {
        let db = Firestore.firestore()
        db.collection("cityList").document("KjhxTtFDStraY61eDFPV").delete() { err in
            if err != nil {
                self.loadWithError?()
            } else {
                self.loadWithDataSource?()
            }
        }
    }
    
    
    func getCityList() {
        // Get the menu option based on the access level
        let db = Firestore.firestore()
        db.collection("cityList").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                self.loadWithError?()
            } else {
                
                let models = querySnapshot?.documents.compactMap { (document) -> CityModel? in
                    if let model = CityModel(dictionary: document.data()) {
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
