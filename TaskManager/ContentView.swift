//
//  ContentView.swift
//  TaskManager
//
//  Created by Jannatun Nahar Papia on 13/6/22.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
