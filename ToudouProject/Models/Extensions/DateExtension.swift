//
//  DateExtension.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import Foundation

extension Date {
    
    var simpleDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: self)
    }
    
    var hourTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var medium: String {
        self.formatted(date: .abbreviated, time: .shortened)
    }
    
    var short: String {
        self.formatted(date: .abbreviated, time: .omitted)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
