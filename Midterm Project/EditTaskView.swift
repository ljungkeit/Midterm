//
//  EditTaskView.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import SwiftUI

struct EditTaskView: View {
    @EnvironmentObject var data: TaskData
    @Environment(\.dismiss) var dismiss
    
    // The task being edited (nil = creating a new one)
    var taskToEdit: TaskItem?
    
    // Form fields
    @State private var name = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var category = "Personal"
    @State private var estTime: Float = 15        // in minutes, default 15
    
    var body: some View {
        Form {
            // Basic info
            Section("Task Details") {
                TextField("Title", text: $name)
                TextField("Description (optional)", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            
            // Category dropdown — pulls from shared data
            Section("Category") {
                Picker("Category", selection: $category) {
                    ForEach(data.categories, id: \.self) { cat in
                        Text(cat).tag(cat)
                    }
                }
            }
            
            // Estimated time — minutes, increments of 15
            Section("Estimated Time") {
                Stepper("\(Int(estTime)) min",
                        value: $estTime, in: 15...480, step: 15)
            }
        }
        .navigationTitle(taskToEdit == nil ? "New Task" : "Edit Task")
        .toolbar {
            // Cancel button (top left)
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            // Save/Update button (top right)
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(taskToEdit == nil ? "Save" : "Update") {
                    if let existing = taskToEdit {
                        // Update existing task, keep same id and status
                        var updated = existing
                        updated.name = name
                        updated.description = description.isEmpty ? nil : description
                        updated.dueDate = dueDate
                        updated.category = category
                        updated.estTime = estTime
                        data.updateTask(updated)
                    } else {
                        // Add brand new task (status defaults to .notStarted)
                        let newTask = TaskItem(
                            name: name,
                            description: description.isEmpty ? nil : description,
                            dueDate: dueDate,
                            category: category,
                            estTime: estTime
                        )
                        data.addTask(newTask)
                    }
                    dismiss()
                }
                .disabled(name.isEmpty || data.categories.isEmpty)
            }
        }
        .onAppear {
            // Pre-fill fields if editing
            if let t = taskToEdit {
                name = t.name
                description = t.description ?? ""
                dueDate = t.dueDate
                category = t.category
                estTime = t.estTime
            } else {
                // For new tasks, default to first available category
                category = data.categories.first ?? "Personal"
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditTaskView(taskToEdit: nil).environmentObject(TaskData())
    }
}
