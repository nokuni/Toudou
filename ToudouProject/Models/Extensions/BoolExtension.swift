//
//  BoolExtension.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/03/23.
//

import Foundation

extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = value != 0
    }
}
