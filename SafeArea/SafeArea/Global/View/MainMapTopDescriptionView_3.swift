//
//  MainMapTopDescriptionView_3.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI

struct MainMapTopDescriptionView_3: View {
    // MARK: - PROPERTY
    let chargeDescription = Text("낙뢰에 의한 ")
        + Text("감전 위험")
            .bold()
        + Text("이 있어요.\n")
    + Text("절대 야외 충전소를 이용하지 마세요.")
        .bold()
    
    // MARK: - BODY
    var body: some View {
        VStack{
            chargeDescription
                .pretendarText(fontSize: 16)
        }
    }
}

struct MainMapTopDescriptionView_3_Previews: PreviewProvider {
    static var previews: some View {
        MainMapTopDescriptionView_3()
            .previewLayout(.sizeThatFits)
    }
}
