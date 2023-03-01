//
//  EditAndValidateTaskButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct EditAndValidateTaskButtonView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var toudouVM: ToudouViewModel
    @ObservedObject var task: TaskEntity
    var body: some View {
        Button {
            toudouVM.isTaskEditing.toggle()
        } label: {
            Text("Edit")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.yingYang)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor.cornerRadius(10))
        }
        
        Button {
            toudouVM.toggleTaskValidation(task: task)
            dismiss()
        } label: {
            Text("Validate")
                .fontWeight(.bold)
                .font(.title3)
                .foregroundColor(.yingYang)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.greenApp.cornerRadius(10))
        }
    }
}

struct EditAndValidateTaskButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditAndValidateTaskButtonView(task: TaskEntity(context: CoreDataManager.shared.container.viewContext))
    }
}
