//
//  GuideSelectButtonView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI

struct GuideSelectButtonView: View {
    
    @Binding var guidePageNumber: Int
    
    var body: some View {
        VStack(spacing:-1) {
            HStack {
                VStack(spacing: 17){
                    Button(action: {
                        guidePageNumber = 0
                    }) {
                        Text("전기차 관리")
                            .pretendarText(fontSize: 18, fontWeight: .semibold)
                            .foregroundColor(guidePageNumber == 0 ? Color.safeGreen : Color(hex: "C5C5C5"))
                    }
                    
                    Divider()
                        .frame(minHeight: 2)
                        .overlay(guidePageNumber == 0 ? Color.safeGreen : Color.clear)
                }
                VStack(spacing: 17){
                    Button(action: {
                        guidePageNumber = 1
                    }) {
                        Text("전기차 충전")
                            .pretendarText(fontSize: 18, fontWeight: .semibold)
                            .foregroundColor(guidePageNumber == 1 ? Color.safeGreen : Color(hex: "C5C5C5"))
                    }
                    Divider()
                        .frame(minHeight: 2)
                        .overlay(guidePageNumber == 1 ? Color.safeGreen : Color.clear)
                        
                }
                VStack(spacing: 17){
                    Button(action: {
                        guidePageNumber = 2
                    }) {
                        Text("긴급  상황")
                            .pretendarText(fontSize: 18, fontWeight: .semibold)
                            .foregroundColor(guidePageNumber == 2 ? Color.safeGreen : Color(hex: "C5C5C5"))
                    }
                    Divider()
                        .frame(minHeight: 2)
                        .overlay(guidePageNumber == 2 ? Color.safeGreen : Color.clear)
                }
            }
            .padding(.leading, 25)
            .padding(.trailing, 25)
            
            .border(Color.black, width: 0)
            
            Divider()
        }
    }
}

struct GuideSelectButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GuideSelectButtonView(guidePageNumber: .constant(0))
    }
}
