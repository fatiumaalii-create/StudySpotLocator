//
//  Study_SpotApp.swift
//  Study Spot
//
//  Created by apple on 21/10/2026.
//

import SwiftUI
import SwiftData
import UserNotifications


@Model
class StudySpot {
    var id: UUID
    var name: String
    var notes: String
    var icon: String
    var rating: Int
    var hasCoffee: Bool
    var drinkBooked: String
    var bookingSaved: Bool
    var reminderMinutes: Int
    var reminderNotification: Bool

    init(name: String, notes: String, icon: String, rating: Int, hasCoffee: Bool) {
        self.id = UUID()
        self.name = name
        self.notes = notes
        self.icon = icon
        self.rating = rating
        self.hasCoffee = hasCoffee
        self.drinkBooked = "No drink"
        self.bookingSaved = false
        self.reminderMinutes = 0
        self.reminderNotification = false
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                    @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
}

let notificationDelegate = NotificationDelegate()

@main
struct Study_SpotApp: App {

    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: StudySpot.self)      
    }
}

