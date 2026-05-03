//
//  Midterm_ProjectApp.swift
//  Midterm Project
//
//  Created by Luca Thomas Jungkeit on 3/25/26.
//

import SwiftUI

@main
struct Midterm_ProjectApp: App {
    @StateObject var data = TaskData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
        }
    }
}
