//
//  DateTimer.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import Foundation

class DateTimer: ObservableObject {
    
    var timer: Timer?
    
    @Published var remainingTime: String = ""
    
    func stop() { timer?.invalidate() }
    
    func start(with date: Date) {
        stop()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            let currentDate = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate, to: date)
            
            let years = components.year ?? 0
            let months = components.month ?? 0
            let days = components.day ?? 0
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            let seconds = components.second ?? 0
            
            self.remainingTime = "\(years) years \(months) months \(days) days \(hours) hours \(minutes) minutes \(seconds) seconds"
            
            if years == 0 {
                self.remainingTime = "\(months) months \(days) days \(hours) hours \(minutes) minutes \(seconds) seconds"
            }
            
            if years == 0 && months == 0 {
                self.remainingTime = "\(days) days \(hours) hours \(minutes) minutes \(seconds) seconds"
            }
            
            if years == 0 && months == 0 && days == 0 {
                self.remainingTime = "\(hours) hours \(minutes) minutes \(seconds) seconds"
            }
            
            if years == 0 && months == 0 && days == 0 && hours == 0 {
                self.remainingTime = "\(minutes) minutes \(seconds) seconds"
            }
            
            if years == 0 && months == 0 && days == 0 && hours == 0 && minutes == 0 {
                self.remainingTime = "\(seconds) seconds"
            }
            
            if years == 0 && months == 0 && days == 0 && hours == 0 && minutes == 0 && seconds == 0 {
                self.remainingTime = "The due date has been reached."
            }
            
            
            if currentDate >= date {
                self.remainingTime = "The due date has been reached."
                timer.invalidate()
            }
        }
        
        timer?.fire()
    }
}
