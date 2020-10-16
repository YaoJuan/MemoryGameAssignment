//
//  ThemeColor.swift
//  Memories
//
//  Created by Bryce on 2020/10/15.
//
import SwiftUI


struct ThemePrimaryColor: ViewModifier {
    @EnvironmentObject var setting: GameSetting
    
    var showBackground: Bool = true
    func body(content: Content) -> some View {
        Group {
            if showBackground {
                content.background(Color(setting.theme.backgroundColor))
            } else {
                content.foregroundColor(Color(setting.theme.backgroundColor))
            }
        }
    }
}


struct ThemeSecondaryColor: ViewModifier {
    @EnvironmentObject var setting: GameSetting
    var showForenground: Bool = true
    func body(content: Content) -> some View {
        Group {
            if showForenground {
                content.foregroundColor(Color(setting.theme.accentColor))
            } else {
                content.background(Color(setting.theme.accentColor))
            }
        }
    }
}


extension View {
    func themePrimaryColor(showBack: Bool = true) -> some View {
        self.modifier(ThemePrimaryColor(showBackground: showBack))
    }
    
    func themeSecondaryColor(showForeground: Bool = true) -> some View {
        self.modifier(ThemeSecondaryColor(showForenground: showForeground))
    }
}
