//
//  ColorExtension.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

extension Color {
    
    // Color Pallete Sample
   /*
    static let black = Color(hex: "000000")
    */
    
    static let safeGreen = Color(hex: "32C52F")
    static let safeRed = Color(hex: "EC5832")
    static let safeGray = Color(hex: "D9D9D9")
    
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
      }
}
