//
//  AddItemsView.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import SwiftUI

struct AddItemsView: View {
    @State var title: String = ""
    @State var info: String = ""
    @State var dueDate: Date = .now
    @State var timestamp: Date = .now
    var  category : Categories
    @EnvironmentObject private var firebaseMnanger: FirebaseManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            Form{
                Section {
                    TextField("Title", text: $title)
                    TextField("Info", text: $info)
                    DatePicker(selection: $dueDate) {
                        Text("Due Date")
                    }
                }
                Button(action: {
                    let item = Items(id: UUID().uuidString, title: title, detels: info, dudate: dueDate)
                    let updatedItems = category.items + [item]
                    let cat = Categories(id: category.id, CategoryName: category.CategoryName, items: updatedItems)
                    Task{
                        try await firebaseMnanger.updatecategory(category:cat)
                        try await firebaseMnanger.fetchCategories()
                    }
                    dismiss()
                }, label: {
                    Text("Add Item")
                }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , alignment: .center)
                    .font(.title3)
                    .buttonStyle(.borderless)
                    .foregroundColor(.white)
                    .listRowBackground(Color.blue)
                
            }.navigationTitle("Add Item")
        }
    }
}

#Preview {
    AddItemsView(category: Categories.init(id: "", CategoryName: ""))
}
