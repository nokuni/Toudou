//
//  ColoredSegmentedPicker.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

protocol ColorPickerDelegate {
    var name: String { get }
    var color: Color { get }
}

struct ColoredSegmentedPicker<M: RawRepresentable & Hashable & CaseIterable & ColorPickerDelegate>: View {
    @Namespace var animation
    var models: [M]
    @Binding var selectedModel: M
    var body: some View {
        HStack {
            ForEach(models, id: \.self) { model in
                Text(model.name.capitalized)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.045, maxHeight: UIScreen.main.bounds.height * 0.045)
                    .font(.system(size: UIScreen.main.bounds.height * 0.015))
                    .foregroundColor("\(selectedModel)" == "\(model)" ? .yingYang : .yangYing)
                    .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height * 0.05, maxHeight: UIScreen.main.bounds.height * 0.05)
                    .background(
                        ZStack {
                            if "\(selectedModel)" != "\(model)" {
                                Color.clear
                            } else {
                                selectedModel.color
                                    .cornerRadius(10)
                                    .matchedGeometryEffect(id: "Tab", in: animation)
                            }
                        }
                    )
                    .onTapGesture {
                        withAnimation {
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
    }
}
