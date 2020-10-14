//
//  Pie.swift
//  Memories
//
//  Created by Bryce on 2020/9/29.
//

import SwiftUI

struct Pie: Shape {
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians )
        }
        set {
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }
    
    var startAngle: Angle
    var endAngle: Angle
    var closeWise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height, rect.width) * 0.5
        
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )
        
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: closeWise)
        
        return path
    }
}
