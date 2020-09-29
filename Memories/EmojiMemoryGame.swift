//
//  EmojiMemoryGame.swift
//  Memories
//
//  Created by 赵思 on 2020/9/27.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🕷", "🎃", "👹", "🤡"]
        return MemoryGame(numberOfPairs: emojis.count) { index  in
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
}
