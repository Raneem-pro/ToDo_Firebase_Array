//
//  CategoryItemsViews.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import SwiftUI

struct CategoryItemsViews: View {
    var  category : Categories
    @EnvironmentObject private var firebaseMnanger: FirebaseManager
    @State private var isShowingAddingItemsView = false
    var body: some View {
            List{
                ForEach(category.items){ item in
                    NavigationLink {
                       
                    } label: {
                        Text(item.title)
                    }.swipeActions(edge: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/ , allowsFullSwipe: true){
                        Button{
                            guard let index = category.items.firstIndex(where: { $0.id == item.id }) else {
                                return
                            }
                            var updatedItems = category.items
                            updatedItems.remove(at: index)
                            let updatedCategory = Categories(id: category.id, CategoryName: category.CategoryName, items: updatedItems)
                            Task {
                                try await firebaseMnanger.updatecategory(category: updatedCategory)
                                try await firebaseMnanger.fetchCategories()
                            }
                        } label: {
                            Image(systemName: "trash")
                        }.tint(.red)

                    }
                }
            }.navigationTitle(category.CategoryName)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            isShowingAddingItemsView.toggle()
                        }label: {
                            Image(systemName: "plus")
                        }
                    }
                }.sheet(isPresented:$isShowingAddingItemsView){
                    AddItemsView(category: category)
                }
        
    }
}

#Preview {
    CategoryItemsViews(category:Categories.init(id: "", CategoryName: ""))
}
