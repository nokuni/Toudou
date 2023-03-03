//
//  SortOrderButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/03/23.
//

import SwiftUI

struct SortOrderButtonView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var body: some View {
        if !toudouVM.tasks.isEmpty {
            Button(action: {
                toudouVM.switchSortOrder()
            }) {
                HStack {
                    Text("\(toudouVM.sortOrder.description.capitalized)")
                    Image(systemName: toudouVM.sortOrder.rawValue ? "arrow.down" : "arrow.up")
                }
            }
        }
    }
}

struct SortOrderButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SortOrderButtonView()
    }
}
