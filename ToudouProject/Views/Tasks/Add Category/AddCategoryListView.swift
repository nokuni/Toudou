//
//  AddCategoryListView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct AddCategoryListView: View {
    private let grid = [GridItem](repeating: .init(.flexible()), count: 6)
    @Binding var taskCategory: TaskCategory
    @Binding var selectedIconIndex: Int
    var body: some View {
        ScrollView {
            LazyVGrid(columns: grid) {
                ForEach(TaskCategory.icons.indices, id: \.self) { index in
                    Button(action: {
                        taskCategory.icon = TaskCategory.icons[index]
                        selectedIconIndex = index
                    }) {
                        Image(TaskCategory.icons[index])
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.12, maxHeight: UIScreen.main.bounds.height * 0.12)
        .background(Color(UIColor.systemGray5).cornerRadius(10))
    }
}

struct AddCategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryListView(taskCategory: .constant(TaskCategory()), selectedIconIndex: .constant(0))
    }
}
