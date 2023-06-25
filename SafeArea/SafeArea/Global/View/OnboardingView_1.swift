//
//  OnboardingView_1.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingView_1: View {
    var body: some View {
        VStack(spacing:0){
            Text("안전하게 충전하다, 안전충전")
                .pretendarText(fontSize: 24, fontWeight: .semibold)
                .padding(.bottom, 9)
            Text("당신이 전기차를 안전하게 충전할 수 있도록!\n당신의 배터리가 완전하게 충전될 수 있도록!\n안전충전은 당신의 안전하고 완전한 충전을 돕는 앱이에요.")
                .multilineTextAlignment(.center)
                .pretendarText(fontSize: 14, fontWeight: .regular)
                .padding(.bottom, 114)
            
            
            HStack {
                Image("OnboardingViewImage_1")
                    .resizable()
                    .frame(width: 89, height: 89)
                    .padding(.leading, 68)
                Spacer()
            }
            
            Spacer()
        } //: VSTACK
        .ignoresSafeArea()
    }
}

struct OnboardingView_1_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView_1()
            .previewLayout(.fixed(width: 390, height: 723))
    }
}
