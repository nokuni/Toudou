//
//  AddTaskCategoriesListView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

struct AddTaskCategoriesListView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var toudouVM: ToudouViewModel
    @Binding var taskCategory: TaskCategory
    var body: some View {
        List {
            ForEach(toudouVM.taskCategories) { category in
                Button(action: {
                    if let name = category.name,
                       let icon = category.icon {
                        taskCategory.name = name
                        taskCategory.icon = icon
                    }
                    dismiss()
                }) {
                    HStack {
                        if let icon = category.icon,
                           let name = category.name {
                            Image(icon)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.height * 0.03, height: UIScreen.main.bounds.height * 0.03)
                            Text(name)
                                .foregroundColor(.primary)
                                .padding(.leading)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Categories")
            }
        }
    }
}

struct AddTaskCategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskCategoriesListView(taskCategory: .constant(TaskCategory()))
    }
}
