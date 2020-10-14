//
//  EmojiMemoryContentView.swift
//  Memories
//
//  Created by Bryce on 2020/9/22.
//

import SwiftUI
import CoreData

struct EmojiMemoryContentView: View {
    @ObservedObject var emojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        
        VStack {
            Grid(emojiMemoryGame.cards) { card  in
                SingleCard(card: card).onTapGesture {
                    withAnimation(.linear) {
                        emojiMemoryGame.choose(card: card)
                    }
                }.padding(5)
            }
            .foregroundColor(.orange)
            .padding()
            Button(action: {
                withAnimation(.easeInOut) {
                    emojiMemoryGame.resetGame()
                }
                
            }, label: {
                Label("New Game", systemImage: "flame.fill")
            })
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct SingleCard: View {
    
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader(content: { geometry in
            body(for: geometry.size)
        })
    }
    
    @State private var animateBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animateBonusRemaining = card.bonusRemainning
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animateBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if !card.isMatched || card.isFaceUp {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0 - Self.offsetRotationAngle), endAngle: Angle(degrees: -animateBonusRemaining * 360 - Self.offsetRotationAngle), closeWise: true)
                         .onAppear(perform: {
                             startBonusTimeAnimation()
                         })
                    } else {
                        Pie(startAngle: Angle(degrees: 0 - Self.offsetRotationAngle), endAngle: Angle(degrees: -card.bonusRemainning * 360 - Self.offsetRotationAngle), closeWise: true)
                    }
                }
                .padding(Self.cardPadding)
                .opacity(Self.cardOpacity)
                .transition(.scale)


               Text(card.content)
                .rotationEffect(Angle(degrees: card.isMatched ? Self.matchedRotationAngle : Self.unMatchedRotationAngle))
                .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }.clarify(isFaceUp: card.isFaceUp).font(Font.system(size: Self.fontSize(size: size)))
            .transition(AnyTransition.scale)
        }
    }
    
    static let cardOpacity: Double = 0.4
    static let cardPadding: CGFloat = 5
    static let fontScaleFactor: CGFloat = 0.75
    static let matchedRotationAngle: Double = 360
    static let offsetRotationAngle: Double = 90
    static let unMatchedRotationAngle: Double = 0
    static func fontSize(size:CGSize) -> CGFloat {
        let minFloat = min(size.width, size.height)
        return minFloat * Self.fontScaleFactor
    }
}
