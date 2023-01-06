//
//  DeleteModifier.swift
//  ToudouProject
//
//  Created by Maertens Yann-Christophe on 04/01/23.
//

import SwiftUI

struct EditRowModifier: ViewModifier {
    
    @Binding var offset: CGSize
    var canDelete: Bool
    @State var initialOffset: CGSize = .zero
    @State var contentWidth: CGFloat = 0.0
    @State var willDeleteIfReleased = false
    
    let edit: () -> Void
    let delete: () -> Void
    let enter: () -> Void
    let reset: () -> Void
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.accentColor)
                            Text("Edit")
                                .fontWeight(.bold)
                                .font(.caption)
                                .foregroundColor(.white)
                                .opacity(offset.width <= -120 ? 1 : 0)
                                .layoutPriority(-1)
                                .animation(.none, value: offset)
                        }
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    edit()
                                }
                        )
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.redApp)
                            Text("Delete")
                                .fontWeight(.bold)
                                .font(.caption)
                                .foregroundColor(.white)
                                .opacity(offset.width <= -120 ? 1 : 0)
                                .layoutPriority(-1)
                                .animation(.none, value: offset)
                        }
                        .gesture(
                            TapGesture()
                                .onEnded {
                                    deleteRow()
                                }
                        )
                    }
                    .frame(width: -offset.width)
                    .offset(x: geometry.size.width)
                    .onAppear { contentWidth = geometry.size.width }
                }
            )
            .offset(x: offset.width, y: 0)
            .gesture (
                DragGesture()
                    .onChanged { gesture in
                        if gesture.translation.width + initialOffset.width <= 0 {
                            self.offset.width = gesture.translation.width + initialOffset.width
                        }
                        if self.offset.width < -deletionDistance && !willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        } else if offset.width > -deletionDistance && willDeleteIfReleased {
                            hapticFeedback()
                            willDeleteIfReleased.toggle()
                        }
                    }
                    .onEnded { _ in
                        if offset.width < -deletionDistance {
                            deleteRow()
                        } else if offset.width < -halfDeletionDistance {
                            offset.width = -tappableDeletionWidth
                            initialOffset.width = -tappableDeletionWidth
                            enter()
                        } else {
                            offset = .zero
                            initialOffset = .zero
                            reset()
                        }
                    }
            )
            .animation(.interactiveSpring(), value: offset)
    }
    
    private func deleteRow() {
        if canDelete {
            offset.width = -contentWidth
            delete()
        }
    }
    
    private func hapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    //MARK: Constants
    
    let deletionDistance = CGFloat(200)
    let halfDeletionDistance = CGFloat(50)
    let tappableDeletionWidth = CGFloat(120)
    
}
