//
//  TaskDateFieldView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 03/01/23.
//

import SwiftUI

struct TaskDateFieldView: View {
    @Binding var dueDate: Date
    var body: some View {
        DatePicker(selection: $dueDate, in: Date()...) {
            Text("Date")
        }
    }
}

struct TaskDateFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDateFieldView(dueDate: .constant(Date()))
    }
}
