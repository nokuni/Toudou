//
//  SheetTopContentView.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 01/03/23.
//

import SwiftUI

struct SheetTopContentView: View {
    var title: String
    var contextualLabel: String?
    var isContextualActionDisabled: Bool = true
    var contextualAction: (() -> Void)?
    var dismissAction: () -> Void
    var body: some View {
        
        HStack {
            Button("Cancel") { dismissAction() }
            Spacer()
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            
            if let contextualLabel = contextualLabel {
                Button(contextualLabel) { contextualAction?() }
                    .fontWeight(.bold)
                    .disabled(isContextualActionDisabled)
            }
        }
    }
}

struct SheetTopContentView_Previews: PreviewProvider {
    static var previews: some View {
        SheetTopContentView(title: "", dismissAction: { })
    }
}
