//
//  ThemeView.swift
//  Memories
//
//  Created by Bryce on 2020/10/16.
//

import SwiftUI

struct ThemeView: View {
    var themes = Theme.allCases
    
    @State private var selectedThemeIndex = Theme.allCases.firstIndex { $0 == GameSetting.theme }! as Int
    
    @EnvironmentObject var setting: GameSetting
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
            ZStack {
                VStack {
                    
                    Form {
                        Picker("Theme Picker", selection: $selectedThemeIndex.onChange(themeChanged)) {
                            ForEach(0 ..< themes.count) {
                                Text("\(themes[$0].rawValue)  \(themes[$0].emojiSet.joined(separator: ", "))")
                            }
                        }.pickerStyle(InlinePickerStyle())
                    }
                }
            }.background(Color(setting.theme.backgroundColor))
            .edgesIgnoringSafeArea(.bottom)
    }
    
    func themeChanged(in index: Int) {
        setting.theme = themes[index]
        GameSetting.theme = themes[index]
    }
    
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView()
    }
}
