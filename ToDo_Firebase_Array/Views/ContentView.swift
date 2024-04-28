//
//  ContentView.swift
//  ToDo_Firebase_Array
//
//  Created by رنيم القرني on 19/10/1445 AH.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var firebaseManager: FirebaseManager
    @State private var isShowingAddCategoryView = false
    @State private var selectedCategory: Categories?

    var body: some View {
        NavigationView {
            List {
                ForEach(firebaseManager.categories) { category in
                    NavigationLink {
                        
                    } label: {
                        HStack {
                            Text(category.CategoryName)
                            Text("(\(category.items.count))")
                            Spacer()
                            Menu {
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text("Edit")
                                    Image(systemName: "square.and.pencil")
                                }
                                Button(action: {
                                    Task {
                                        try await firebaseManager.deletcategory(category: category)
                                        try? await firebaseManager.fetchCategories()
                                    }
                                }) {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal.circle")
                            }.buttonStyle(.borderless)
                        }
                    }
                }
            }
            .navigationTitle("To Do")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddCategoryView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(item: $selectedCategory) { category in
                UpdateCategoryView(category: category)
            }
            .sheet(isPresented: $isShowingAddCategoryView) {
                            AddCategoryView()
                        }
        }
        .onAppear {
            Task {
                try await firebaseManager.fetchCategories()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(FirebaseManager())
        
}
