//
//  Task_TrackerApp.swift
//  Task Tracker
//
//  Created by Michael Hewitt (Home) on 10/21/23.
//

// from https://sarunw.com/posts/swiftui-menu-bar-app/

// TODO
// [ ] Menu item to open schedule
// [ ] Pull today's tasks from schedule
// [ ] Flash "*** NO TASK ***" to get attention
// [ ] Access from hewitt@coda.io account
// [ ] Global shortcut to access menubar
// [ ] Launch at startup

import SwiftUI

@main
struct Task_TrackerApp: App {
    // 1
    @State var currentNumber: String = "1"
    
    var body: some Scene {
        // 2
        MenuBarExtra("*** NO TASK ***") {
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
            Button("Open Schedule") {
                // from "OSX Swift open URL in default browser" stack overflow
                let url = URL(string: "https://staging.coda.io/d/_d1yceUzNKlU")!
                NSWorkspace.shared.open(url)
            }
            .keyboardShortcut("o")
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }
}
