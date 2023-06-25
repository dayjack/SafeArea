//
//  SafeAreaApp.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/19.
//

import SwiftUI

@main
struct SafeAreaApp: App {
    
    init() {
        /*
         ##Font Family
         Pretendard-Regular
         Pretendard-Light
         Pretendard-Medium
         Pretendard-SemiBold
         Pretendard-Bold
         */
        Font.registerFonts(fontName: "Pretendard-Bold")
        Font.registerFonts(fontName: "Pretendard-Light")
        Font.registerFonts(fontName: "Pretendard-Medium")
        Font.registerFonts(fontName: "Pretendard-Regular")
        Font.registerFonts(fontName: "Pretendard-SemiBold")
    }
    
    var body: some Scene {
        WindowGroup {
            MainApp()
        }
        
    }
}
