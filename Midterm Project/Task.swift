//
//  Task.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import Foundation
import Combine
// Three possible completion states for a task
enum CompletionStatus: String {
    case notStarted, inProgress, completed
}
struct Category: Identifiable {
    var id = UUID()
    var name: String
}
struct TaskItem: Identifiable {
    let id = UUID()
    var name: String
    var description: String?
    var dueDate: Date
    var category: String
    var estTime: Float          // in hours
    var status: CompletionStatus = .notStarted
}
