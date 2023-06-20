//
//  GuideDetailView_1.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI

struct GuideDetailView_1: View {
    // MARK: - PROPERTY
    let arrayText: [(Int, String)] = [(1, "충전계 게이지 30-90% 수준을 유지하기"), (2, "차량에 큰 충격이 발생한 경우 서비스 센터(지정 정\n비사)에게 점검받기"), (3, "한 달에 한 번은 완속 충전기로 충전하기"), (4, "장기간 미사용시 12V 배터리를 차단하고, 3개월에 \n한 번 이상 충전하기"), (5, "차량의 주황색 케이블은 300V 이상의 전기가 흐르\n므로 접촉하지 않도록 주의하기"), (6, "엔진룸, 전기보터, 충전 접속 부위, 고전압 배터리 세차 금지"), (7, "충전 중 세차 금지")]
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<7){ index in
                ZStack(alignment: .topLeading) {
                    Text("\(arrayText[index].0)")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.leading, 24)
                    Text(arrayText[index].1)
                        .font(.system(size: 16))
                        .padding(.leading, 48)
                        .padding(.trailing, 24)
                }
//                .padding(.horizontal, 24)
                .padding(.bottom, 8)
            }
        }
    }
}
// MARK: - PREVIEW
struct GuideDetailView_1_Previews: PreviewProvider {
    static var previews: some View {
        GuideDetailView_1()
    }
}
