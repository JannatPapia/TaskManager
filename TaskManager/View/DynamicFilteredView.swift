//
//  DynamicFilteredView.swift
//  TaskManagement
//
//  Created by MacBook Air M1 on 18/1/22.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content:View,T>: View where T : NSManagedObject  {
    
    // MARK: Core Data Requst
    @FetchRequest var request : FetchedResults<T>
    let content: (T) -> Content
    
    //MARK: Building Custom ForEach whitch will be give Coredate object to build view
    init(currentTab: String, @ViewBuilder content : @escaping (T) ->Content){
        
        //MARK: Predicate to Filter current date Tasks
        let calendar = Calendar.current
        var predicate: NSPredicate!
        if currentTab == "Today"{
            let today = calendar.startOfDay(for: Date())
            let towmmrow = calendar.date(byAdding: .day, value: 1, to: today)!
            
            // Filter Key
            let filterKey = "deadline"
            //this will fatech task between today and tommorow which is 24 hour
            //0-false ,1-true
             predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,towmmrow,0])
            
            // Intializing Request with NSPredicate
        } else if currentTab == "Upcoming"{
            let today = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!)
            let towmmrow = Date.distantFuture
            
            // Filter Key
            let filterKey = "deadline"
            //this will fatech task between today and tommorow which is 24 hour
            //0-false ,1-true
             predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,towmmrow,0])
        } else if currentTab == "Failed" {
            let today = calendar.startOfDay(for: Date())
            let towmmrow = Date.distantFuture
            
            // Filter Key
            let filterKey = "deadline"
            //this will fatech task between today and tommorow which is 24 hour
            //0-false ,1-true
             predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@ AND isCompleted == %i", argumentArray: [today,towmmrow,0])
        }
        else {
            predicate = NSPredicate(format: "isCompleted == %i", argumentArray: [1])
        }
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.deadline, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        Group{
            if request.isEmpty {
                Text("No Tasks found!!!")
                    .font(.system(size: 16))
                    .fontWeight(.light)
                    .offset(y:100)
            }else{
                ForEach(request,id:\.objectID) { object in
                    self.content(object)
                    
                }
            }
        }
    }
}


