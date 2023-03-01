//
//  TaskPriority.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

@objc
public enum TaskPriority: Int16, CaseIterable, RawRepresentable, ColorPickerDelegate {
    case none
    case low
    case medium
    case high
    
    var name: String {
        switch self {
        case .none: return "none"
        case .low: return "low"
        case .medium: return "medium"
        case .high: return "high"
        }
    }
    
    var color: Color {
        switch self {
        case .none: return .greenApp
        case .low: return .yellowApp
        case .medium: return .orangeApp
        case .high: return .redApp
        }
    }
    
    static func priorityColor(_ priority: Int) -> Color {
        if let priority = allCases.first(where: { $0.rawValue == priority }) {
            return priority.color
        }
        return .yingYang
    }
    
    public init?(rawValue: Int16) {
        switch rawValue {
        case 0:
            self = .none
        case 1:
            self = .low
        case 2:
            self = .medium
        case 3:
            self = .high
        default:
            return nil
        }
    }
}
