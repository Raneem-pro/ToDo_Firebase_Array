//
//  AddCategoryView.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import SwiftUI

struct AddCategoryView: View {
    @State var CategoryTitle : String = ""
    @EnvironmentObject private var firebaseMnanger: FirebaseManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form{
                Section{
                    TextField("Add Title" , text: $CategoryTitle )
                }
                Button{
                    let category = Categories(id: UUID().uuidString, CategoryName: CategoryTitle)
                    Task{
                        try await firebaseMnanger.createCategory(category: category)
                        try await firebaseMnanger.fetchCategories()
                    }
                    dismiss()
                }label: {
                    Text("Creat Category")
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , alignment: .center)
                    .font(.title3)
                    .buttonStyle(.borderless)
                    .foregroundColor(.white)
                    .listRowBackground(Color.blue)
                
            }.navigationTitle("Add Category")
        }
    }
}

#Preview {
    AddCategoryView()
        .navigationTitle("Add Category")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(FirebaseManager())
}
