//
//  MarkerInfoView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/24.
//

import SwiftUI

struct MarkerInfoView: View {
    // MARK: - PROPERTY
    @Binding var charging: ChargingStationAnnotation?
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 0){
                    Text(charging?.statNm ?? "데이터 없음")
                        .pretendarText(fontSize: 16, fontWeight: .medium)
                        .padding(.bottom, 8)
                    HStack {
                        Text(charging?.addr ?? "주소 미확인")
                            .pretendarText(fontSize: 12, fontWeight: .regular)
                        Text("  |  ")
                        Text("435m")
                            .pretendarText(fontSize: 12, fontWeight: .medium)
                    }
                    .opacity(0.5)
                    .padding(.bottom, 9)
                    
                    if (charging?.ready == 0) {
                        HStack(spacing: 0) {
                            Text("모두 이용 중")
                                .pretendarText(fontSize: 12, fontWeight: .regular)
                                .foregroundColor(Color.safeRed)
                                .padding(.trailing)
                            Text("\(charging?.charging ?? 0) / \(charging?.total ?? 0)")
                                .pretendarText(fontSize: 12, fontWeight: .regular)
                        }
                    }
                    else {
                        HStack {
                            Text("충전 가능")
                                .pretendarText(fontSize: 12, fontWeight: .regular)
                            Text("\(charging?.charging ?? 0) / \(charging?.total ?? 0)")
                                .pretendarText(fontSize: 12, fontWeight: .regular)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 18)
            .padding(.leading, 24)
        } //: ZSTACK
    }
}

//struct MarkerInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        MarkerInfoView()
//            .previewLayout(.fixed(width: 391, height: 191))
//    }
//}
