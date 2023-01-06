//
//  NotificationManager.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import UserNotifications

class NotificationManager: ObservableObject {
    static let shared = NotificationManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error)
            }
        }
    }
    
    func scheduleReminderNotification(of task: TaskModel) {
        let content = UNMutableNotificationContent()
        
        content.title = task.title
        content.body = task.reminder.rawValue + " event"
        content.subtitle = task.date.medium
        content.sound = .default
        
        let calendar = Calendar.current
        var taskDate = task.date
        
        var isReminderLaunched = true
        
        if let reminder = TaskAlertReminder.allCases.first(where: {
            $0.rawValue == task.reminder.rawValue
        }) {
            switch reminder {
            case .none: isReminderLaunched = false
            case .onTime: isReminderLaunched = false
            case .fiveMinutesBefore:
                taskDate = calendar.date(byAdding: .minute, value: -5, to: taskDate) ?? Date()
            case .tenMinutesBefore:
                taskDate = calendar.date(byAdding: .minute, value: -10, to: taskDate) ?? Date()
            case .fifteenMinutesBefore:
                taskDate = calendar.date(byAdding: .minute, value: -15, to: taskDate) ?? Date()
            case .thirtyMinutesBefore:
                taskDate = calendar.date(byAdding: .minute, value: -30, to: taskDate) ?? Date()
            case .oneHourBefore:
                taskDate = calendar.date(byAdding: .hour, value: -1, to: taskDate) ?? Date()
            case .twoHoursBefore:
                taskDate = calendar.date(byAdding: .hour, value: -2, to: taskDate) ?? Date()
            case .oneDayBefore:
                taskDate = calendar.date(byAdding: .day, value: -1, to: taskDate) ?? Date()
            case .twoDaysBefore:
                taskDate = calendar.date(byAdding: .day, value: -2, to: taskDate) ?? Date()
            case .oneWeekBefore:
                taskDate = calendar.date(byAdding: .day, value: -7, to: taskDate) ?? Date()
            }
        }
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: taskDate.components, repeats: false)
        
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: dateTrigger)
        
        if isReminderLaunched { UNUserNotificationCenter.current().add(request) }
    }
    
    func scheduleNotification(of task: TaskModel) {
        
        let toudouVM = ToudouViewModel()
        
        let content = UNMutableNotificationContent()
        
        content.title = task.title
        content.body = "\(task.date.medium)"
        content.subtitle = task.notes
        content.sound = .default
        content.badge = 1
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: task.date.components, repeats: false)
        
        let request = UNNotificationRequest(identifier: task.id.uuidString, content: content, trigger: dateTrigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
