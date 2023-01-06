//
//  AddCategoryTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct AddCategoryTopContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @Binding var taskCategory: TaskCategory
    @Binding var isAddingCategory: Bool
    var body: some View {
        HStack {
            Button("Cancel") { isAddingCategory.toggle() }
            Spacer()
            Text("New Task")
                .fontWeight(.semibold)
            Spacer()
            Button("Add") {
                toudouVM.createTaskCategory(taskCategory: taskCategory)
                isAddingCategory.toggle()
            }
            .fontWeight(.bold)
        }
    }
}

struct AddCategoryTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryTopContentView(taskCategory: .constant(TaskCategory()), isAddingCategory: .constant(false))
    }
}
