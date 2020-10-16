//
//  GameSetting.swift
//  Memories
//
//  Created by Bryce on 2020/10/15.
//

import SwiftUI

class GameSetting: ObservableObject {
    static var theme: Theme = .sea
    
    @Published var theme: Theme = .sea {
        didSet {
            Self.theme = theme
        }
    }
    
    init(theme: Theme = .sea) {
        self.theme = theme
    }
    
}


extension Theme {
    var accentColor: UIColor {
        switch self {
        case .sea:
            return #colorLiteral(red: 0.07008511573, green: 0.8457072973, blue: 0.7848315835, alpha: 0.8889929366)
        case .halloween:
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case .birds:
            return #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        case .animals:
            return #colorLiteral(red: 0.2882383764, green: 0.2056168318, blue: 0.06613719463, alpha: 1)
        case .xmas:
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .sea:
            return #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        case .halloween:
            return #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        case .birds:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .animals:
            return #colorLiteral(red: 0.9273172021, green: 0.8738321662, blue: 0.6386776567, alpha: 1)
        case .xmas:
            return #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
    }
}
