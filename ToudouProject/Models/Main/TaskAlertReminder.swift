//
//  TaskAlertReminder.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import Foundation
import Utility_Toolbox

@objc
public enum TaskAlertReminder: Int16, RawRepresentable, CaseIterable {
    case none
    case onTime
    case fiveMinutesBefore
    case tenMinutesBefore
    case fifteenMinutesBefore
    case thirtyMinutesBefore
    case oneHourBefore
    case twoHoursBefore
    case oneDayBefore
    case twoDaysBefore
    case oneWeekBefore
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .none:
            return "None"
        case .onTime:
            return "At time of event"
        case .fiveMinutesBefore:
            return "5 minutes before"
        case .tenMinutesBefore:
            return "10 minutes before"
        case .fifteenMinutesBefore:
            return "15 minutes before"
        case .thirtyMinutesBefore:
            return "30 minutes before"
        case .oneHourBefore:
            return "1 hour before"
        case .twoHoursBefore:
            return "2 hours before"
        case .oneDayBefore:
            return "1 day before"
        case .twoDaysBefore:
            return "2 days before"
        case .oneWeekBefore:
            return "1 week before"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "None":
            self = .none
        case "At time of event":
            self = .onTime
        case "5 minutes before":
            self = .fiveMinutesBefore
        case "10 minutes before":
            self = .tenMinutesBefore
        case "15 minutes before":
            self = .fifteenMinutesBefore
        case "30 minutes before":
            self = .thirtyMinutesBefore
        case "1 hour before":
            self = .oneHourBefore
        case "2 hours before":
            self = .oneHourBefore
        case "1 day before":
            self = .oneDayBefore
        case "2 days before":
            self = .twoDaysBefore
        case "1 week before":
            self = .oneWeekBefore
        default:
            return nil
        }
    }
    
    func reminderDate(from date: Date) -> Date {
        switch self {
        case .none:
            return Date.now
        case .onTime:
            return date
        case .fiveMinutesBefore:
            return date.addingDate(component: .minute, value: -5)
        case .tenMinutesBefore:
            return date.addingDate(component: .minute, value: -10)
        case .fifteenMinutesBefore:
            return date.addingDate(component: .minute, value: -15)
        case .thirtyMinutesBefore:
            return date.addingDate(component: .minute, value: -30)
        case .oneHourBefore:
            return date.addingDate(component: .hour, value: -1)
        case .twoHoursBefore:
            return date.addingDate(component: .hour, value: -2)
        case .oneDayBefore:
            return date.addingDate(component: .day, value: -1)
        case .twoDaysBefore:
            return date.addingDate(component: .day, value: -2)
        case .oneWeekBefore:
            return date.addingDate(component: .day, value: -7)
        }
    }
}
