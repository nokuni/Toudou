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
    @Binding var category: TaskCategory
    var body: some View {
        List {
            ForEach(TaskCategory.allCases, id: \.self) { category in
                Button(action: {
                    self.category = category
                    dismiss()
                }) {
                    HStack {
                        Image(category.icon)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.height * 0.03, height: UIScreen.main.bounds.height * 0.03)
                        Text(category.rawValue)
                            .foregroundColor(.primary)
                            .padding(.leading)
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
        AddTaskCategoriesListView(category: .constant(.chill))
    }
}
