//
//  OnboardingIndicator.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingIndicator: View {
    // MARK: - PROPERTY
    
    @Binding var pageNm: Int
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0){
            HStack(spacing: 0){
                ForEach(1...5, id: \.self) { index in
                    if (pageNm == index){
                        Capsule()
                            .frame(width: 16, height: 8)
                            .foregroundColor(Color.safeGreen)
                            .padding(.trailing, index == 5 ? 0 : 7)
                    } else {
                        Circle()
                            .frame(width: 8, height: 8)
                            .foregroundColor(Color.safeGray)
                            .padding(.trailing, index == 5 ? 0 : 7)
                    }
                }
                
            } //: HSTACK
        } //: VSTACK
    }
}

// MARK: - PREVIEW
struct OnboardingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIndicator(pageNm: .constant(5))
            .previewLayout(.fixed(width: 390, height: 8))
            .padding()
    }
}
