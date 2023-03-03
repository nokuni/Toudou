//
//  SortOrder.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/03/23.
//

import Foundation

enum SortOrder: Bool {
    
    case ascending
    case descending
    
    mutating func toggle() {
        self = self == .ascending ? .descending : .ascending
    }
    
    var description: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
}
