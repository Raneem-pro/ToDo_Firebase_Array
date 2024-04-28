//
//  UpdateItemView.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import SwiftUI

struct UpdateItemView: View {
    @State var title: String = ""
    @State var info: String = ""
    @State var dueDate: Date = .now
    @State var timestamp: Date = .now
    var  category : Categories
    @State var isDone =  false
    var  item : Items
    @EnvironmentObject private var firebaseMnanger: FirebaseManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
            Form{
                Section {
                    TextField("Title", text: $title)
                    TextField("Info", text: $info)
                    DatePicker(selection: $dueDate) {
                        Text("Due Date")
                    }
                    Toggle(isOn: $isDone) {
                        Text("is Done")
                    }
                }
                Button(action: {
                            guard let index = category.items.firstIndex(where: { $0.id == item.id }) else {
                                return
                            }
                            var updatedItems = category.items
                            updatedItems[index] = Items(id: item.id, title: title, detels: info, dudate: dueDate)
                            let updatedCategory = Categories(id: category.id, CategoryName: category.CategoryName, items: updatedItems)
                            Task {
                                try await firebaseMnanger.updatecategory(category: updatedCategory)
                                try await firebaseMnanger.fetchCategories()
                            }
                            dismiss()
                }, label: {
                    Text("Update Item")
                }).frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , alignment: .center)
                    .font(.title3)
                    .buttonStyle(.borderless)
                    .foregroundColor(.white)
                    .listRowBackground(Color.blue)
                
            }.navigationTitle("Update Item")
                .onAppear{
                    title = item.title
                    info = item.detels
                    isDone = item.isDine
                    dueDate = item.dudate
                    timestamp = item.timestamp
                }
        
    }
}

#Preview {
    UpdateItemView(category: Categories.init(id: "", CategoryName: ""), item: Items.init(id: "", title: "", detels: ""))
        .environmentObject(FirebaseManager())
}
