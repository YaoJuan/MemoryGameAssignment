//
//  Clarify.swift
//  Memories
//
//  Created by Bryce on 2020/9/29.
//

import SwiftUI

struct Clarify: AnimatableModifier {
    private var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    private var isFaceUp: Bool {
        rotation < 90
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: Self.DrawingConstans.cornerRadius).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: Self.DrawingConstans.cornerRadius).stroke(lineWidth: Self.DrawingConstans.strokeWidth).foregroundColor(.orange)
                content
            }
            .opacity(isFaceUp ? 1.0 : 0)

            RoundedRectangle(cornerRadius: Self.DrawingConstans.cornerRadius).fill()
                .opacity(isFaceUp ? 0 : 1.0)
        }
        .rotation3DEffect(
            Angle(degrees: rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
            )
    }
    
    //MARK: -Drawing Constans
    private struct DrawingConstans {
        static let cornerRadius: CGFloat = 10
        static let strokeWidth: CGFloat = 3
    }
}

extension View {
    func clarify(isFaceUp: Bool) -> some View {
        self.modifier(Clarify(isFaceUp: isFaceUp))
    }
}
