//
//  MemoryGame.swift
//  Memories
//
//  Created by Bryce on 2020/9/27.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: Array<Card>
    
    private(set) var score: Int = 0
    
    private(set) var needMinusScore: Int = 0
    
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
            caculateScore(with: chooseIndex)
        }
    }
    
    mutating private func caculateScore(with index: Int) {

        let card = cards[index]
        
        // find out how much score should be minus
        _ =  cards.filter { $0.pastFaceUpTime > 0 && $0.id != card.id }
            .filter { $0.content == card.content && !$0.hasEarnedBonus}
            .map { _ in needMinusScore += 1 }
        
        score = cards.reduce(into: 0) { $0 += $1.hasEarnedBonus ? 1 : 0 } - needMinusScore
    }
    
    init(numberOfPairs: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairs {
            let content = cardContentFactory(index)
            cards.append(Card(id: index * 2, content: content))
            cards.append(Card(id: index * 2 + 1, content: content))
        }
        
        cards.shuffle()
    }
    
    struct Card:  Identifiable {
        var id: Int
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var content: CardContent
        var isMatched = false
        
        //MARK: -- Bonus Time
        var bonusTimeLimit: TimeInterval = 6
        
        // 卡牌已经朝上展示过的时间
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                let result = pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
                return result
            } else {
                return pastFaceUpTime
            }
        }
        
        // 上一次翻过来的时间
        var lastFaceUpDate: Date?
        
        // 记录本次翻过来之前朝上的时间
        var pastFaceUpTime: TimeInterval = 0
        
        // 剩余时间
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // 剩余时间比百分比
        var bonusRemainning: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // 是否获得得分
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        // 是否用完了时间
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // 当牌被翻回去，或者匹配上了
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    

}
