//
//  GuideDetailView_3.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI

struct GuideDetailView_3: View {
    // MARK: - PROPERTY
    
    let arrayText: [(String, String)] = [("🚨", "창문 열고 환기 후 안전한 장소로 대피 ※ 차량 내 전선과 특히 고전압 케이블(주황색)은 만지지 말 것"), ("🔥", "충전 중일 경우, 충전기 측 긴급 전원 차단 스위치\n를 눌러 전원 공급 차단 후 119 신고"), ("🔥", "소규모 화재(연기 등)일 경우, 전기 화재용 소화기\n를 사용하여 화재 진압 및 안전한 곳에 대피하여 \n119 신고 (소화기는 바람을 등지고 사용)"), ("🌊", "즉시 시동을 끄고 안전한 장소로 대피 후 신고"), ("🚍", "네 바퀴가 모두 움직이지 않는 상태로 견인 (부득\n이 두 바퀴 견인 시에는 구동되는 바퀴는 고정하여\n 견인")]
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<5){ index in
                ZStack(alignment: .topLeading) {
                    Text("\(arrayText[index].0)")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.leading, 24)
                    Text(arrayText[index].1)
                        .font(.system(size: 16))
                        .padding(.leading, 56)
                        .padding(.trailing, 24)
                }
//                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
        }
    }
}
// MARK: - PREVIEW
struct GuideDetailView_3_Previews: PreviewProvider {
    static var previews: some View {
        GuideDetailView_3()
    }
}
