//
//  CategorySummaryView.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 5/3/26.
//

import SwiftUI

struct CategorySummaryView: View {
    @EnvironmentObject var data: TaskData
    
    // Computes a dictionary of [categoryName: totalMinutes]
    // using Dictionary(grouping:)
    private var totalsByCategory: [String: Float] {
        // Group all tasks by their category name
        let grouped = Dictionary(grouping: data.tasks, by: { (task: TaskItem) in task.category })
        // For each group, reduce the tasks' estTime values into a single sum
        return grouped.mapValues { tasks in
            tasks.reduce(0) { (runningTotal: Float, task: TaskItem) in
                runningTotal + task.estTime
            }
        }
    }
    
    // Sorted list for stable display order
    private var sortedTotals: [(category: String, minutes: Float)] {
        let pairs: [(category: String, minutes: Float)] = totalsByCategory.map {
            (key: String, value: Float) in
            (category: key, minutes: value)
        }
        return pairs.sorted { (a: (category: String, minutes: Float),
                              b: (category: String, minutes: Float)) in
            a.category < b.category
        }
    }
    
    var body: some View {
        List {
                ForEach(sortedTotals, id: \.category) { entry in
                    HStack {
                        Text(entry.category)
                        Spacer()
                        Text(formatTime(entry.minutes))
                            .foregroundColor(.secondary)
                    }
                }
        }
        .navigationTitle("Time by Category")
    }
    
    // Formats minutes into a readable string like "2 hrs 30 min" or "45 min"
    private func formatTime(_ totalMinutes: Float) -> String {
        let mins = Int(totalMinutes)
        let hours = mins / 60
        let remaining = mins % 60
        
        if hours == 0 {
            return "\(remaining) min"
        } else if remaining == 0 {
            return "\(hours) hr\(hours == 1 ? "" : "s")"
        } else {
            return "\(hours) hr\(hours == 1 ? "" : "s") \(remaining) min"
        }
    }
}

#Preview {
    NavigationStack {
        CategorySummaryView().environmentObject(TaskData())
    }
}
