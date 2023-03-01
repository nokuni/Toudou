//
//  FilterSegmentedPicker.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

/// A filter segmented picker.
struct FilterSegmentedPicker<M: RawRepresentable & Hashable & CaseIterable>: View {
    @Namespace var animation
    var models: [M]
    @Binding var selectedModel: M
    var fontSize: Font { models.count > 5 ? .caption : .callout }
    var body: some View {
        HStack {
            ForEach(models, id: \.self) { model in
                Text((model.rawValue as! String).capitalized)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
                    .background(Color.white.opacity(0.01))
                    .font(fontSize)
                    .foregroundColor("\(selectedModel)" == "\(model)" ? .yingYang : .yangYing)
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
                    .background(
                        ZStack {
                            if "\(selectedModel)" != "\(model)" {
                                Color.clear
                            } else {
                                Color.accentColor
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selectedModel = model
                        }
                    }
            }
        }
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(UIColor.systemGray5))
        )
        .padding(.horizontal)
    }
}
