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
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .circular).padding(.horizontal).foregroundColor(.red)
                HStack {
                    Text("Score: \(emojiMemoryGame.score)")
                    Button(action: {
                        withAnimation(.easeInOut) {
                            emojiMemoryGame.resetGame()
                        }
                        
                    }, label: {
                        Label("New Game", systemImage: "flame.fill").foregroundColor(.green)
                    })
                }.frame(alignment: .topLeading)
            }
            .frame(height: 44)
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


                ZStack {
                    Text(card.content)
                        .font(Font.system(size: Self.fontSize(size: size)))
                        .rotationEffect(Angle(degrees: card.isMatched ? Self.matchedRotationAngle : Self.unMatchedRotationAngle))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                    Group {
                        if card.isMatched && !card.hasEarnedBonus {
                            Text("overtime").font(Font.system(size: Self.overtimeFontSize(size: size)))
                                .foregroundColor(.red)
                                .offset(CGSize(width: 0, height: -size.height / 8 / Self.fontScaleFactor))
                                .transition(AnyTransition.move(edge:.top)
                                                .animation(.easeInOut(duration: 1))
                                            )
                        }
                    }

                }

            }.clarify(isFaceUp: card.isFaceUp)
//            .transition(AnyTransition.slide)
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
    
    static func overtimeFontSize(size: CGSize) -> CGFloat {
        let minFloat = min(size.width, size.height)
        return minFloat / 8
    }
}
