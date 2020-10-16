//
//  EmojiMemoryGame.swift
//  Memories
//
//  Created by Bryce on 2020/9/27.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var memoryGame: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = GameSetting.theme
        let emojis = theme.emojiSet
        let random = Int.random(in: 2...emojis.count)
        return MemoryGame(numberOfPairs:random) { index  in
            return emojis[index]
        }
        
    }
    
    // MARK: -Access to the Model
    var score: String {
        return "\(memoryGame.score)"
    }
    var cards: Array<MemoryGame<String>.Card> {
        return memoryGame.cards
    }
    
    // MARK: -Intent(s)
    func choose(card: MemoryGame<String>.Card) {
        memoryGame.chooseCard(card: card)
    }
    
    func resetGame() {
        memoryGame = Self.createMemoryGame()
    }
}
