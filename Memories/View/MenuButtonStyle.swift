//
//  MenuButtonStyle.swift
//  Memories
//
//  Created by Bryce on 2020/10/15.
//

import SwiftUI

struct MenuButtonStyle: ButtonStyle {
    var primaryColor: UIColor
    
    var secondaryColor: UIColor {
        primaryColor.pe.lighterColor
    }
    
    init(with color: UIColor) {
        primaryColor = color
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
//            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color(primaryColor), Color(secondaryColor)]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
