//
//  TaskCategory.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import Foundation

@objc
public enum TaskCategory: Int16, RawRepresentable, CaseIterable {
    case important
    case work
    case people
    case food
    case chill
    case chore
    
    public typealias RawValue = String
    
    public var rawValue: RawValue {
        switch self {
        case .important:
            return "Important"
        case .work:
            return "Work"
        case .people:
            return "People"
        case .food:
            return "Food"
        case .chill:
            return "Chill"
        case .chore:
            return "Chore"
        }
    }
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "Important":
            self = .important
        case "Work":
            self = .work
        case "People":
            self = .people
        case "Food":
            self = .food
        case "Chill":
            self = .chill
        case "Chore":
            self = .chore
        default:
            return nil
        }
    }
    
    var icon: String {
        switch self {
        case .important:
            return "important.icon"
        case .work:
            return "work.icon"
        case .people:
            return "people.icon"
        case .food:
            return "food.icon"
        case .chill:
            return "chill.icon"
        case .chore:
            return "chore.icon"
        }
    }
}
