//
//  StartView.swift
//  Memories
//
//  Created by Bryce on 2020/10/15.
//

import SwiftUI

struct StartView: View {
    
    @EnvironmentObject var setting: GameSetting
    @State var gameActive = false
    @State var themeActive = false
    
    var memoryGame: EmojiMemoryGame = EmojiMemoryGame()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: EmojiMemoryContentView(emojiMemoryGame: memoryGame),isActive: $gameActive) {
                        Button("New Game") {
                            memoryGame.resetGame()
                            gameActive = true
                        }.foregroundColor(Color(setting.theme.backgroundColor))
                        .buttonStyle(MenuButtonStyle(with: setting.theme.accentColor))
                }
                
                Button("Choose theme") {
                    themeActive = true
                }
                
                .foregroundColor(Color(setting.theme.backgroundColor)).buttonStyle(MenuButtonStyle(with: setting.theme.accentColor)).sheet(isPresented: $themeActive) {
                    ThemeView().environmentObject(setting)
                }
                
            }.frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center)
            .background(Color(setting.theme.backgroundColor)).edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}



