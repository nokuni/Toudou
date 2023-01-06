//
//  AddCategoryView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct AddCategoryView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @State var selectedCategoryIndex: Int = 0
    @State var taskCategory = TaskCategory()
    @FocusState var focusField: FocusField?
    @Binding var isAddingCategory: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color.yingYang.ignoresSafeArea()
                VStack(spacing: 30) {
                    AddCategoryTopContentView(taskCategory: $taskCategory, isAddingCategory: $isAddingCategory)
                    Image(TaskCategory.icons[selectedCategoryIndex])
                        .resizable()
                        .frame(width: UIScreen.main.bounds.height * 0.1, height: UIScreen.main.bounds.height * 0.1)
                    AddCategoryNameFieldView(taskCategory: $taskCategory, focusField: $focusField)
                    AddCategoryListView(taskCategory: $taskCategory, selectedIconIndex: $selectedCategoryIndex)
                    
                    Spacer()
                }
                .padding()
            }
            .onAppear {
                taskCategory.icon = TaskCategory.icons[selectedCategoryIndex]
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(isAddingCategory: .constant(false))
    }
}
