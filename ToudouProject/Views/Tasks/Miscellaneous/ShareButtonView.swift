//
//  ShareButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 06/01/23.
//

import SwiftUI

struct ShareButtonView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    @ObservedObject var task: TaskEntity
    var body: some View {
        ShareLink(item: task.title,
                  subject: Text("You have until \(task.dueDate?.medium ?? "") to do it."),
                  message: Text(task.priority.shareMessage)) {
            Image(systemName: "square.and.arrow.up.fill")
            .fontWeight(.semibold)
            .foregroundColor(.accentColor)
        }
    }
}

struct ShareButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ShareButtonView(task: TaskEntity(context: CoreDataManager.shared.container.viewContext))
    }
}
