//
//  TaskspaceModel.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import Foundation

struct TaskspaceModel: Identifiable {
    var id = UUID()
    var name: String = ""
    var image: String = "space.image"
    var tasks = [String]()
    var belonging: TaskspaceBelonging = .owned
    var contributors = [String]()
    var password: String = ""
}
