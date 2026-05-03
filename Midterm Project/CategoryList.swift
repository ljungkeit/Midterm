//
//  CategoryList.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import SwiftUI

struct CategoryList: View {
    @EnvironmentObject var data: TaskData
    @State private var newCategory = ""
    
    var body: some View {
        List {
            // Existing categories 
            ForEach(data.categories, id: \.self) { cat in
                Text(cat)
            }
            .onDelete(perform: data.deleteCategory)
            
            // Add new category section
            Section {
                TextField("New category", text: $newCategory)
                Button("Add") {
                    let trimmed = newCategory.trimmingCharacters(in: .whitespaces)
                    // Only add if non-empty and not already in the list
                    if !trimmed.isEmpty && !data.categories.contains(trimmed) {
                        data.categories.append(trimmed)
                        newCategory = ""
                    }
                }
            }
        }
        .navigationTitle("Categories")
    }
}

#Preview {
    NavigationStack {
        CategoryList().environmentObject(TaskData())
    }
}
