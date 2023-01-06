//
//  TaskTopButtonsView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct TaskTopButtonsView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @Binding var isAddingCategory: Bool
    private let url = URL(string: "https://www.google.com")!
    var body: some View {
        HStack {
            Button(action: {
                isAddingCategory.toggle()
            }) {
                HStack {
                    Text("New category")
                    Image(systemName: "text.badge.plus")
                }
                .fontWeight(.semibold)
                .foregroundColor(.yingYang)
                .padding()
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
                .background(Color.accentColor.cornerRadius(10))
            }
            
            ShareLink(item: "https://www.toudou.com/\(toudouVM.taskspaceTitle)") {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up.fill")
                }
                .fontWeight(.semibold)
                .foregroundColor(.yingYang)
                .padding()
                .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
                .background(Color.accentColor.cornerRadius(10))
            }
        }
    }
}

struct TaskTopButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTopButtonsView(isAddingCategory: .constant(false))
    }
}
