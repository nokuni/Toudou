//
//  TaskCategoryAndTitleView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct TaskCategoryAndTitleView: View {
    @ObservedObject var task: TaskEntity
    var body: some View {
        Image(task.category.icon)
            .resizable()
            .scaledToFit()
        
        Text(task.title)
            .fontWeight(.bold)
            .font(.title)
    }
}
