//
//  TaskRowView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskRowView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var task: TaskEntity
    var body: some View {
        GeometryReader { geometry in
            HStack {
                
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(task.priority.color)
                    .frame(width: geometry.size.height, height: geometry.size.height)
                    .opacity(task.isDone ? 0.2 : 1)
                
                VStack(alignment: .leading) {
                    Text(task.title)
                        .fontWeight(.bold)
                        .foregroundColor(task.isDone ? .secondary : .yangYing)
                        .strikethrough(task.isDone, color: .secondary)
                    Text(task.dueDate?.medium ?? "No expiration date")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .strikethrough(task.isDone, color: .secondary)
                }
                
                Spacer()
                
                if toudouVM.hasTaskExpired(task) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color.yellowApp)
                        Text("Expired")
                            .font(.caption)
                    }
                }
                
                Image(task.category.icon)
                    .resizable()
                    .scaledToFit()
                    .opacity(task.isDone ? 0.2 : 1)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .padding(.vertical)
    }
}
