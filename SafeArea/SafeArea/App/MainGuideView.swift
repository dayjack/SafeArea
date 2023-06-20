//
//  MainGuideView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

struct MainGuideView: View {
    
    @State var guidePageNumber: Int = 0
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("전기차 안전 가이드")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(EdgeInsets(top: 104, leading: 24, bottom: 21, trailing: 0))
                Spacer()
            }
            GuidePageTabView()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 24)
                .frame(maxHeight: 210)
                
            GuideSelectButtonView(guidePageNumber: $guidePageNumber)
                .padding(.top, 25)
                .padding(.bottom, 14)
            
            switch guidePageNumber{
            case 0:
                GuideDetailView_1()
            case 1:
                GuideDetailView_2()
            case 2:
                GuideDetailView_3()
            default:
                GuideDetailView_1()
            }
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct MainGuideView_Previews: PreviewProvider {
    static var previews: some View {
        MainGuideView()
    }
}
