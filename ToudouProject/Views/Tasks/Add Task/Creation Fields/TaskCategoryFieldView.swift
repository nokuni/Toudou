//
//  TaskCategoryFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskCategoryFieldView: View {
    @Binding var taskCategory: TaskCategory
    var body: some View {
        NavigationLink(destination: AddTaskCategoriesListView(taskCategory: $taskCategory)) {
            HStack {
                Text("Category")
                    .foregroundColor(.primary)
                Spacer()
                if let icon = taskCategory.icon,
                   let name = taskCategory.name {
                    Image(icon)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height * 0.03, height: UIScreen.main.bounds.height * 0.03)
                    Text(name)
                        .foregroundColor(.primary)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
            .background(Color(UIColor.systemGray5).cornerRadius(10))
        }
    }
}

struct TaskCategoryFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCategoryFieldView(taskCategory: .constant(TaskCategory()))
    }
}
