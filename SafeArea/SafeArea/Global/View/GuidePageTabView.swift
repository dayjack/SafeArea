//
//  PageTabView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI

struct GuidePageTabView: View {
    // MARK: - PROPERTY
    
    let exampleImage: [String] = ["card1", "card2", "card3"]
        let exampleText: [String] = ["환경을 생각하는 전기차, 제대로 알고 타면 더 깨끗하고 안전하게 사용할 수 있어요!", "전기차 1대는 내연기관차 대비 소나무 303그루 상당의 이산화탄소 절감 효과가 있어요.", "오래될수록 에너지 효율이 떨어지는 내연기관차.\n에너지 효율과 주행거리를 높이는 전기차!"]
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach (0..<3) { index in
                VStack(spacing: 0) {
                    Image(exampleImage[index])
                        .resizable()
                        .frame(width: 228, height: 114)
                        .padding(.top, 10)
                        .padding(.bottom, 6)
                    Text(exampleText[index])
                        .pretendarText(fontSize: 16, fontWeight: .medium)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                    Spacer()
                }
            } //: LOOP
        } //: TAB
        .background(
            Color(hex: "EAEAEA")
        )
        .tabViewStyle(PageTabViewStyle())
    }
}

// MARK: - PREVIEW
struct GuidePageTabView_Previews: PreviewProvider {
    static var previews: some View {
        GuidePageTabView()
            .previewLayout(.fixed(width: 340, height: 210))
    }
}
