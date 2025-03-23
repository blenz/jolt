//
//  JoltApp.swift
//  Jolt Watch App
//
//  Created by Brett Lenz on 3/23/25.
//

import SwiftUI

@main
struct Jolt: App {
    let notificationManager = NotificationManager()

    init() {
        notificationManager.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
