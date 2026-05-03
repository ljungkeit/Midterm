//
//  ContentView.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Tab 1: list of tasks
            NavigationStack {
                ListView()
            }
            .tabItem {
                Label("Tasks", systemImage: "list.bullet.below.rectangle.portrait.fill")
            }
            
            // Tab 2: manage categories
            NavigationStack {
                CategoryList()
            }
            .tabItem {
                Label("Categories", systemImage: "rectangle.grid.1x2")
            }
            
            // Tab 3: time summary by category (extra credit)
            NavigationStack {
                CategorySummaryView()
            }
            .tabItem {
                Label("Summary", systemImage: "chart.bar")
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskData())
}
