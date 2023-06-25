//
//  OnboardingView_2.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingView_2: View {
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("안전하게 충전하다, 안전충전")
                .pretendarText(fontSize: 24, fontWeight: .semibold)
                .padding(.bottom, 9)
            Text("날씨에 따라 가야 하는 충전소가 다르다는 걸 아시나요?\n오늘의 날씨에 알맞는 충전소와 충전 시 주의 사항을 알려드려요.")
                .multilineTextAlignment(.center)
                .pretendarText(fontSize: 14, fontWeight: .regular)
            
            
            ZStack{
                Image("OnboardingRecImage")
                    .resizable()
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("OnboardingViewIphone_1")
                            .resizable()
                            .frame(height: 610)

                    }
                }
                
            }
        }
        .ignoresSafeArea()
    }
}

struct OnboardingView_2_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView_2()
            .previewLayout(.fixed(width: 390, height: 723))
    }
}
