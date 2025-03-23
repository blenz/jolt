//
//  NotificationManager.swift
//  Jolt Watch App
//
//  Created by Brett Lenz on 3/23/25.
//

import UserNotifications

class NotificationManager {
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, error in
            if let error = error {
                print("Permission error: \(error.localizedDescription)")
            }
        }
    }

    func scheduleNotification(at time: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Jolt"
        content.sound = UNNotificationSound.default

        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}
