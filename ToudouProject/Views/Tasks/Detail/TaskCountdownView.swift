//
//  TaskCountdownView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct TaskCountdownView: View {
    var size: CGSize
    @ObservedObject var task: TaskEntity
    @EnvironmentObject var toudouVM: ToudouViewModel
    @ObservedObject var dateTimer: DateTimer
    var body: some View {
        if !task.isDone {
            VStack {
                if task.dueDate != nil {
                    Text("Time left")
                        .fontWeight(.semibold)
                    Text(dateTimer.remainingTime)
                        .font(.callout)
                        .frame(width: size.width)
                } else {
                    Text("No expiration date")
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
