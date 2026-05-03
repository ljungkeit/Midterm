//
//  ListView.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var data: TaskData
    @State private var showingAdd = false           // controls "new task" sheet
    @State private var taskToEdit: TaskItem? = nil  // controls "edit task" sheet
    
    // Date formatter for display
    private var dateFormatter: DateFormatter {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }
    
    var body: some View {
        List {
            ForEach(data.tasks) { task in
                taskRow(task)
            }
            .onDelete(perform: data.deleteTask)   // swipe to delete
        }
        .navigationTitle("TASKS")
        .toolbar {
            // Plus button in top-right opens AddTask sheet
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAdd = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        // Sheet for adding a new task
        .sheet(isPresented: $showingAdd) {
            NavigationStack {
                EditTaskView(taskToEdit: nil)
            }
        }
        // Sheet for editing an existing task
        .sheet(item: $taskToEdit) { task in
            NavigationStack {
                EditTaskView(taskToEdit: task)
            }
        }
    }
    
    // MARK: - Single task row
    @ViewBuilder
    private func taskRow(_ task: TaskItem) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            //name
            Text(task.name)
                .font(.headline)
                
            
            // Category
            Text("Category: \(task.category)")
                .font(.subheadline)
            
            // Due date
            Text("Due: \(dateFormatter.string(from: task.dueDate))")
                .font(.subheadline)
            //status
            Text("\(statusLabel(task.status))")
                .font(.subheadline)
            
            //update button
            Button("Update Status") {
                data.cycleStatus(for: task)
            }
            .buttonStyle(.borderless)
            .controlSize(.small)
            
            //edit button
            Button("Edit") {
                taskToEdit = task
            }
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 4)
    }
    
    
    private func statusLabel(_ status: CompletionStatus) -> String {
        switch status {
        case .notStarted: return "Not Started"
        case .inProgress: return "In Progress"
        case .completed:  return "Completed"
        }
    }
}

#Preview {
    NavigationStack {
        ListView().environmentObject(TaskData())
    }
}
