//
//  EmojiMemoryGame.swift
//  Memories
//
//  Created by Bryce on 2020/9/27.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🕷", "🎃", "👹", "🤡"]
//        let random = Int(arc4random() % (3)) + 2
        let random = Int.random(in: 2...emojis.count)
        return MemoryGame(numberOfPairs:random) { index  in
            return emojis[index]
        }
        
    }
    
    // MARK: -Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: -Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        model.chooseCard(card: card)
    }
    
    func resetGame() {
        model = Self.createMemoryGame()
    }
}
