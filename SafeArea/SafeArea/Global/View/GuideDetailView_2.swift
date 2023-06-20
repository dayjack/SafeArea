//
//  GuideDetailView_2.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI

struct GuideDetailView_2: View {
    // MARK: - PROPERTY
    let arrayText: [(Int, String)] = [(1, "반드시 지정된 국가표준인증 충전기와 어댑터를 사\n용하고, 커넥터 연결 상태 확인하기"), (2, "젖은 손으로 충전기 사용은 금물, 우천 시 충전 장치\n에 수분 유입 주의하기"), (3, "충전 중 충전 커넥터를 임의로 분리하지 않고 충전 \n종료 버튼으로 종료하기"), (4, "충전 케이블 피복 손상, 커넥터 파손 등 안전상태 주\n기적으로 점검하기"), (5, "휴대용 충전기를 이용하여 충전할 경우 멀티탭이나 \n연장선 사용하지 않기"), (6, "우천(번개) 시 실내 충전소 이용")]
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(0..<6){ index in
                ZStack(alignment: .topLeading) {
                    Text("\(arrayText[index].0)")
                        .pretendarText(fontSize: 16)
                        .fontWeight(.semibold)
                        .padding(.leading, 24)
                    Text(arrayText[index].1)
                        .pretendarText(fontSize: 16)
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
struct GuideDetailView_2_Previews: PreviewProvider {
    static var previews: some View {
        GuideDetailView_2()
    }
}
