//
//  PretendardTextModifier.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import Foundation
import SwiftUI

struct PretendardTextModifier: ViewModifier {
    
    var fontSize: CGFloat
    var fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        
        switch fontWeight {
        case .bold:
            content.font(.custom("Pretendard-Bold", size: fontSize))
        case .light:
            content.font(.custom("Pretendard-Light", size: fontSize))
        case .medium:
            content.font(.custom("Pretendard-Medium", size: fontSize))
        case .regular:
            content.font(.custom("Pretendard-Regular", size: fontSize))
        case .semibold:
            content.font(.custom("Pretendard-SemiBold", size: fontSize))
        default:
            content.font(.custom("Pretendard-Medium", size: fontSize))
        }
    }
}
