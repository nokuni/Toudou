//
//  ValidateButtonView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

struct ValidateButtonView: View {
    @EnvironmentObject var toudouVM: ToudouViewModel
    private let animation = ChainAnimation()
    @State private var frame: CGSize = CGSize(width: UIScreen.main.bounds.height * 0.01, height: UIScreen.main.bounds.height * 0.01)
    @State private var hasStartedValidation: Bool = false
    var task: TaskEntity
    var body: some View {
        Button(action: {
            if !hasStartedValidation {
                animation.start(
                    duration: 2,
                    startAction: {
                        hasStartedValidation = true
                        frame = CGSize(width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05)
                    },
                    whileAction: nil,
                    endAction: {
                        toudouVM.validateTask(task: task)
                    })
            } else {
                frame = CGSize(width: UIScreen.main.bounds.height * 0.01, height: UIScreen.main.bounds.height * 0.01)
                animation.cancelTimer()
                hasStartedValidation = false
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: UIScreen.main.bounds.height * 0.05, height: UIScreen.main.bounds.height * 0.05)
                    .foregroundColor(TaskModel.priorityColor(Int(task.priority)))
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.white)
                    .frame(width: frame.width, height: frame.height)
            }
            .animation(.linear(duration: 2.8), value: frame)
        }
    }
}

struct ValidateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ValidateButtonView(task: TaskEntity())
    }
}
