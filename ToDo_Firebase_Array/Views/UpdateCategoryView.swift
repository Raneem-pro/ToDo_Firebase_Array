//
//  UpdateCategoryView.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import SwiftUI

struct UpdateCategoryView: View {
     var category : Categories
    @State var CategoryTitle : String = ""
    @EnvironmentObject private var firebaseMnanger: FirebaseManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Add Title" , text: $CategoryTitle)
                }
                Button{
                    let category = Categories(id: category.id, CategoryName: CategoryTitle )
                    Task{
                        try await firebaseMnanger.updatecategory(category:category)
                        try await firebaseMnanger.fetchCategories()
                    }
                    dismiss()
                }label: {
                    Text("Update Category")
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , alignment: .center)
                    .font(.title3)
                    .buttonStyle(.borderless)
                    .foregroundColor(.white)
                    .listRowBackground(Color.blue)
                
            }.navigationTitle("Update Category")
                .onAppear{
                    CategoryTitle = category.CategoryName
                }
        }
    }
}

#Preview {
    UpdateCategoryView(category: Categories.init(id: "", CategoryName: ""))
}
