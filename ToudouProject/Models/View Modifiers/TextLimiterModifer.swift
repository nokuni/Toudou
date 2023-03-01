//
//  TextLimiterModifer.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 28/02/23.
//

import SwiftUI

struct TextLimiterModifier: ViewModifier {
    @Binding var text: String
    var limit: Int
    func body(content: Content) -> some View {
        content
            .onChange(of: text, perform: { newValue in
                if text.count < limit { text = newValue } else {
                    text = String(text.prefix(limit))
                }
            })
    }
}
