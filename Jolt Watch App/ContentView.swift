//
//  ContentView.swift
//  Jolt Watch App
//
//  Created by Brett Lenz on 3/23/25.
//

import SwiftUI

struct ContentView: View {
    let notificationManager = NotificationManager()

    @State private var reminderTime = Date()

    var body: some View {
        VStack {
            Text("Set Jolt")
                .font(.headline)
                .padding()

            DatePicker(
                "Jolt Time",
                selection: $reminderTime,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()

            Button("Set Jolt") {
                print(reminderTime)
                notificationManager.scheduleNotification(at: reminderTime)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
