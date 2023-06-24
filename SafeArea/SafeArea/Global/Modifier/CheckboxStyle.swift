//
//  CheckboxStyle.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(configuration.isOn ? .safeGreen : .gray)
            configuration.label
            
        }
        .onTapGesture { configuration.isOn.toggle() }
        
    }
}
