//
//  Clarify.swift
//  Memories
//
//  Created by 赵思 on 2020/9/29.
//

import SwiftUI

struct Clarify: ViewModifier{
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: Self.DrawingConstans.cornerRadius).fill().foregroundColor(.white)
                RoundedRectangle(cornerRadius: Self.DrawingConstans.cornerRadius).stroke(lineWidth: Self.DrawingConstans.strokeWidth).foregroundColor(.orange)
                content
            } else {
                    RoundedRectangle(cornerRadius: Self.DrawingConstans.cornerRadius).fill()
            }
        }
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
