//
//  Task_TrackerApp.swift
//  Task Tracker
//
//  Created by Michael Hewitt (Home) on 10/21/23.
//

// from https://sarunw.com/posts/swiftui-menu-bar-app/
// see also https://www.youtube.com/watch?v=ii89L7LVAs4

// TODO
// [*] Menu item to open schedule
// [ ] Update menu items
// [ ] Derive title from currently active task
//     [*] Set timer
//     [*] Manual refresh
//     [*] Execute http request
//     [ ] Query currently active task from Coda
// [ ] Pull today's tasks from schedule
// [ ] Flash "*** NO TASK ***" to get attention
// [ ] Access from hewitt@coda.io account
// [ ] Global shortcut to access menubar
// [ ] Launch at startup

import SwiftUI

// super sophisticated view in menu popup: https://www.youtube.com/watch?v=v1lGPx6m__g

@main
struct Task_TrackerApp: App {
    // 1
    let docId = "1yceUzNKlU"
    @State var currentTitle: String = "*** NO TASK ***"
    @State var number = 0;
    @State var buttons = ["hello", "goodbye"]
    
    // refresh data every 5 seconds (see .onReceive below)
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    func refresh() {
        let codaUrl = URL(string: "https://staging.coda.io/d/_d" + "1yceUzNKlU")!
        let task = URLSession.shared.dataTask(with: codaUrl) {(data, response, error) in
            guard let data = data else { return }
            // print(String(data: data, encoding: .utf8)!)
            number = number + 1
            currentTitle = "foo" + String(number)
            buttons = ["new", "old"]
        }
        task.resume()
    }

    var body: some Scene {
        MenuBarExtra {
            ForEach(buttons, id: \.self) {name in
                Button(name) {
                    currentTitle = "Task 1"
                }
            }
            Button("One") {
                currentTitle = "Task 1"
            }
            .keyboardShortcut("1")
            Button("Two") {
                currentTitle = "2"
            }
            .keyboardShortcut("2")
            Button("Three") {
                currentTitle = "3"
            }
            .keyboardShortcut("3")
            Button("Refresh") {
                refresh()
            }
            .keyboardShortcut("r")
            Button("Open Schedule") {
                // from "OSX Swift open URL in default browser" stack overflow
                let url = URL(string: "https://staging.coda.io/d/_d" + docId)!
                NSWorkspace.shared.open(url)
            }
            .keyboardShortcut("o")
            Divider()
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        } label: {
            Text(currentTitle)
                .onReceive(timer) { _ in
                    refresh()
                }
        }
    }
}
