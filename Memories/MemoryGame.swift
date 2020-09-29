//
//  MemoryGame.swift
//  Memories
//
//  Created by 赵思 on 2020/9/27.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
        
    }
    
    mutating func chooseCard(card: Card) {
        if let chooseIndex = cards.searchFirstIndex(of: card), !cards[chooseIndex].isFaceUp, !cards[chooseIndex].isMatched {

            if let potenialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                if cards[chooseIndex].content == cards[potenialMatchIndex].content {
                    cards[chooseIndex].isMatched = true
                    cards[potenialMatchIndex].isMatched = true
                }
                cards[chooseIndex].isFaceUp = true
                
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chooseIndex
            }
        }
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairs {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
    }
    
    struct Card:  Identifiable {
        var id: Int
        var isFaceUp = false
        var content: CardContent
        var isMatched = false
        
        
    }
}
