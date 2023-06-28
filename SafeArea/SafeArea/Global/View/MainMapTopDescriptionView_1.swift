//
//  MainMapTopDescriptionView_1.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI

struct MainMapTopDescriptionView_1: View {
    
    // MARK: - PROPERTY
    let chargeDescription = Text("물에 의한 ")
        + Text("감전 위험")
            .bold()
        + Text("이 있어요.\n")
    + Text("실내 충전소")
        .bold()
     + Text("를 권장해요.")
    
    // MARK: - BODY
    var body: some View {
        VStack{
            chargeDescription
                .pretendarText(fontSize: 16)
        }
    }
}

// MARK: - PREVIEW
struct MainMapTopDescriptionView_1_Previews: PreviewProvider {
    static var previews: some View {
        MainMapTopDescriptionView_1()
            .previewLayout(.sizeThatFits)
    }
}
