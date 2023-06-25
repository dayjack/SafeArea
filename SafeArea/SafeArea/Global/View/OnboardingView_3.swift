//
//  OnboardingView_3.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingView_3: View {
    var body: some View {
        VStack(spacing: 0) {
            
            Text("꾹 눌러서 빠르게 긴급 신고")
                .pretendarText(fontSize: 24, fontWeight: .semibold)
                .padding(.bottom, 9)
            Text("화재 발생시 119 긴급신고 버튼을 꾹 누르면\n현재 충전소의 위치와 전기차 화재를 알리는 신고 문자를 전송해\n빠르게 대처할 수 있어요")
                .multilineTextAlignment(.center)
                .pretendarText(fontSize: 14, fontWeight: .regular)
            
            
            ZStack{
                Image("OnboardingRecImage")
                    .resizable()
                HStack{
                    Image("OnboardingViewIphone_2")
                        .resizable()
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct OnboardingView_3_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView_3()
            .previewLayout(.fixed(width: 390, height: 723))
    }
}
