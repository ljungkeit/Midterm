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
    
    // Delete tasks at given offsets (for swipe-to-delete)
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // Delete categories at given offsets (for swipe-to-delete)
    func deleteCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
    }
    
    // Cycle through statuses on button tap: Not Started → In Progress → Completed → Not Started
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
