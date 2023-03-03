//
//  SortingButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/03/23.
//

import SwiftUI

struct SortingButtonView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var body: some View {
        if !toudouVM.tasks.isEmpty {
            Menu("Sort") {
                ForEach(TaskSorting.allCases, id: \.self) { sort in
                    Button(action: {
                        toudouVM.selectedSort = sort
                        toudouVM.readTasks()
                    }) {
                        HStack {
                            Text(sort.rawValue)
                            if toudouVM.selectedSort == sort {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SortingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SortingButtonView()
    }
}
