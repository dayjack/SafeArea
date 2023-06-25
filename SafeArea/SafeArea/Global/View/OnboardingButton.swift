//
//  OnboardingButton.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingButton: View {
    var body: some View {
        ZStack {
            Rectangle()
                .cornerRadius(30)
                .foregroundColor(Color.safeGreen)
            Text("시작하기")
                .foregroundColor(.white)
                .pretendarText(fontSize: 20, fontWeight: .medium)
        }
        .ignoresSafeArea()
    }
}

struct OnboardingButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingButton()
            .previewLayout(.fixed(width: 217, height: 52))

    }
}
