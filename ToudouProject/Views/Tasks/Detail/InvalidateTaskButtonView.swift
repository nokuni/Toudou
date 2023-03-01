//
//  InvalidateTaskButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct InvalidateTaskButtonView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var toudouVM: ToudouViewModel
    @ObservedObject var task: TaskEntity
    var body: some View {
        Text("This task has been validated.")
        
        Button {
            toudouVM.toggleTaskValidation(task: task)
            dismiss()
        } label: {
            Text("Invalidate")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.yingYang)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.redApp.cornerRadius(10))
        }
    }
}

struct InvalidateTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        InvalidateTaskButtonView(task: TaskEntity(context: CoreDataManager.shared.container.viewContext))
    }
}
