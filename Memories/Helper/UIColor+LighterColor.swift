//
//  UIColor+LighterColor.swift
//  Memories
//
//  Created by Bryce on 2020/10/15.
//

import UIKit

extension UIColor: ProjectExtensionCompatible { }

extension ProjectExtensive where Base == UIColor {
    var lighterColor: UIColor {
        return lighterColor(removeSaturation: 0.5, resultAlpha: -1)
    }
    
    func lighterColor(removeSaturation val: CGFloat, resultAlpha alpha: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0

        guard base.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            else { return base }
        return UIColor(hue: h,
                       saturation: max(s - val, 0.0),
                       brightness: b,
                       alpha: alpha == -1 ? a : alpha)
    }
}
 
