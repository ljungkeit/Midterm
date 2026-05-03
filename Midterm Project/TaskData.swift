//
//  TaskData.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import Foundation
import SwiftUI
import Combine

class TaskData: ObservableObject {
    // Published so views update automatically when these change
    @Published var tasks: [TaskItem] = []
    @Published var categories: [String] = ["Work", "School", "Personal"]
    
    // Add a new task
    func addTask(_ task: TaskItem) {
        tasks.append(task)
    }
    
    // Update an existing task by id
    func updateTask(_ task: TaskItem) {
        if let index = tasks.firstIndex(where: { (item: TaskItem) in item.id == task.id }) {
            tasks[index] = task
        }
    }
    
    // Delete tasks at given offsets
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Delete categories at given offsets
    func deleteCategory(at offsets: IndexSet) {
            let removedNames = offsets.map { (index: Int) in categories[index] }
            categories.remove(atOffsets: offsets)
            
            // Reassign any task whose category was just deleted
            for i in tasks.indices {
                if removedNames.contains(tasks[i].category) {
                    tasks[i].category = "No Category"
                }
            }
        }
    
    // Cycle through statuses on button tap
    func cycleStatus(for task: TaskItem) {
        if let index = tasks.firstIndex(where: { (item: TaskItem) in item.id == task.id }) {
            switch tasks[index].status {
            case .notStarted: tasks[index].status = .inProgress
            case .inProgress: tasks[index].status = .completed
            case .completed:  tasks[index].status = .notStarted
            }
        }
    }
}
