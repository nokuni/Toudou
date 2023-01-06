//
//  TaskAlertReminder.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import Foundation

enum TaskAlertReminder: String, CaseIterable {
    case none = "None"
    case onTime = "At time of event"
    case fiveMinutesBefore = "5 minutes before"
    case tenMinutesBefore = "10 minutes before"
    case fifteenMinutesBefore = "15 minutes before"
    case thirtyMinutesBefore = "30 minutes before"
    case oneHourBefore = "1 hour before"
    case twoHoursBefore = "2 hours before"
    case oneDayBefore = "1 day before"
    case twoDaysBefore = "2 days before"
    case oneWeekBefore = "1 week before"
}
