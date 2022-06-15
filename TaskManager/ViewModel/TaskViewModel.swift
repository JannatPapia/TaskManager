//
//  TaskViewModel.swift
//  TaskManager
//
//  Created by Jannatun Nahar Papia on 14/6/22.
//

import SwiftUI
import CoreData

class TaskViewModel: ObservableObject {
    @Published var currentTab: String = "Today"
    
    //MARK: New Task Properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    //MARK: Adding Task to Core Data
    func addTask(contex: NSManagedObjectContext) -> Bool {
        let task = Task(context: contex)
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        
        if let _ = try? contex.save() {
            return true
        }
        return false
    }
    
    //MARK: Resetting Data
    func resetTaskData() {
        taskType = "Basic"
        taskColor = "Yellow"
        taskTitle = ""
        taskDeadline = Date()
    }
}


