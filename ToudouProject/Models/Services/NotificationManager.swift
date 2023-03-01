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
    
    func scheduleReminderNotification(of task: TaskEntity) {
        let content = UNMutableNotificationContent()
        
        guard let id = task.id else { return }
        guard let notificationDate = task.dueDate else { return }
        
        content.title = task.title
        content.body = task.reminder.rawValue + " event"
        content.subtitle = notificationDate.medium
        content.sound = .default
        
        var taskDate = notificationDate
        
        var isReminderLaunched = true
        
        if let reminder = TaskAlertReminder.allCases.first(where: {
            $0.rawValue == task.reminder.rawValue
        }) {
            switch reminder {
            case .none:
                isReminderLaunched = false
            case .onTime:
                break
            case .fiveMinutesBefore:
                taskDate.add(component: .minute, value: -5)
            case .tenMinutesBefore:
                taskDate.add(component: .minute, value: -10)
            case .fifteenMinutesBefore:
                taskDate.add(component: .minute, value: -15)
            case .thirtyMinutesBefore:
                taskDate.add(component: .minute, value: -30)
            case .oneHourBefore:
                taskDate.add(component: .hour, value: -1)
            case .twoHoursBefore:
                taskDate.add(component: .hour, value: -2)
            case .oneDayBefore:
                taskDate.add(component: .day, value: -1)
            case .twoDaysBefore:
                taskDate.add(component: .day, value: -2)
            case .oneWeekBefore:
                taskDate.add(component: .day, value: -7)
            }
        }
        
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: taskDate.components, repeats: false)
        
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: dateTrigger)
        
        if isReminderLaunched { UNUserNotificationCenter.current().add(request) }
    }
    
    func removeNotifications(from identifier: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
//    func scheduleNotification(of task: TaskEntity) {
//        
//        let content = UNMutableNotificationContent()
//        
//        content.title = task.title
//        content.body = "\(task.date.medium)"
//        content.subtitle = task.notes
//        content.sound = .default
//        content.badge = 1
//        
//        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: task.date.components, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: dateTrigger)
//        
//        UNUserNotificationCenter.current().add(request)
//    }
}
