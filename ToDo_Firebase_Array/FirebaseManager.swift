//
//  FirebaseManager.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Categories: Codable , Identifiable{
    let id: String
    var CategoryName : String
    var items : [Items] = []
}

struct Items: Codable , Identifiable{
    let id: String
    var title : String
    var detels : String
    var isDine : Bool = false
    var dudate : Date = .now
    var timestamp : Date = .now
}

class FirebaseManager: NSObject , ObservableObject{
    @Published var categories : [Categories] = []

    let firestore : Firestore
    
    override init() {
        self.firestore = Firestore.firestore()
    }
    
    func createCategory (category: Categories)  async throws {
        do{
            try firestore.collection("Categories").document(category.id).setData(from: category)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchCategories() async throws {
        let querySnapshot = try await firestore.collection("Categories").getDocuments()
        /// decode the fetching data to be in the same form of my bilud object
        /// this slice of code  $0.data(as: Item.self)  convert dictinary into object
        let items = querySnapshot.documents.compactMap({try? $0.data(as: Categories.self)})
        DispatchQueue.main.async {
            self.categories = items
        }
    }
    
    func updatecategory(category: Categories) async throws {
        do{
            try  firestore.collection("Categories").document(category.id).setData(from: category)
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    func deletcategory(category: Categories) async throws {
        do{
            try await firestore.collection("Categories").document(category.id).delete()
        }catch{
            print(error.localizedDescription)
        }
        
    }

    
}
