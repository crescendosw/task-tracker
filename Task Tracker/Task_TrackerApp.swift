//
//  Task_TrackerApp.swift
//  Task Tracker
//
//  Created by Michael Hewitt (Home) on 10/21/23.
//

// from https://sarunw.com/posts/swiftui-menu-bar-app/

import SwiftUI

@main
struct Task_TrackerApp: App {
    // 1
    @State var currentNumber: String = "1"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // 2
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            // 3
            Button("One") {
                currentNumber = "1"
            }
            .keyboardShortcut("1")
            Button("Two") {
                currentNumber = "2"
            }
            .keyboardShortcut("2")
            Button("Three") {
                currentNumber = "3"
            }
            .keyboardShortcut("3")
            Divider()
            Button("Quit") {

                NSApplication.shared.terminate(nil)

            }
            .keyboardShortcut("q")
        }
    }
}
