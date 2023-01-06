//
//  TaskspaceRowContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 05/01/23.
//

import SwiftUI

struct TaskspaceRowContentView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    var taskspace: TaskspaceEntity
    var body: some View {
        HStack {
            if let image = taskspace.image {
                Image(image)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.height * 0.06, height: UIScreen.main.bounds.height * 0.06)
                    .clipShape(Circle())
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                if let name = taskspace.name {
                    Text(name)
                        .font(.title3)
                }
                if toudouVM.selectedTaskspace?.id == taskspace.id {
                    Text("SELECTED")
                        .fontWeight(.black)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
            Spacer()
            
            Image(taskspace.isOwning ? "owning.image" : "contributor.image")
                .resizable()
                .frame(width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05, alignment: .topTrailing)
        }
        .padding()
    }
}

struct TaskspaceRowContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskspaceRowContentView(taskspace: TaskspaceEntity())
    }
}
