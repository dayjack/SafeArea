//
//  MainMapTopDescriptionView_2.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI

struct MainMapTopDescriptionView_2: View {
    // MARK: - PROPERTY
    let chargeDescription = Text("배터리 발열 위험")
        .bold()
    + Text("이 있어요.\n")
    
    + Text("지붕이 있는 충전소")
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

struct MainMapTopDescriptionView_2_Previews: PreviewProvider {
    static var previews: some View {
        MainMapTopDescriptionView_2()
            .previewLayout(.sizeThatFits)
    }
}
