//
//  Theme.swift
//  Memories
//
//  Created by Bryce on 2020/10/15.
//


enum Theme: String, Identifiable, CaseIterable {
    case sea = "Sea"
    case halloween = "Halloween"
    case xmas = "X-Mas"
    case animals = "Animals"
    case birds = "Birds"
    var id: String  { self.rawValue }
    
    
    var emojiSet: [String] {
        switch self {
        case .sea:
            return ["🐬", "🐳", "🦈", "🐟", "🐡"]
        case .halloween:
            return ["🎃", "🕸", "🕷", "👻", "👽"]
        case .birds:
            return ["🦜", "🦢", "🐧", "🦆", "🦉"]
        case .animals:
            return ["🐴", "🦓", "🐖", "🦥", "🐏"]
        case .xmas:
            return ["🤶🏻", "🎄", "🎉", "🎁", "🇨🇽"]
        }
    }
}
