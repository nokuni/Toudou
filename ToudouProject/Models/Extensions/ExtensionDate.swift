//
//  ExtensionDate.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import Foundation

extension Date {
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var medium: String {
        return self.formatted(date: .abbreviated, time: .shortened)
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    var components: DateComponents {
        var dateComponents = DateComponents()
        
        let date = self.get(.day, .month, .year, .hour, .minute, .second)
        
        if let day = date.day,
           let month = date.month,
           let year = date.year,
           let hour = date.hour,
           let minute = date.minute,
           let second = date.second {
            dateComponents.day = day
            dateComponents.month = month
            dateComponents.year = year
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.second = second
        }
        
        return dateComponents
    }
}
