//
//  MainMapTopDescriptionView_4.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI

struct MainMapTopDescriptionView_4: View {
    // MARK: - PROPERTY
    let chargeDescription = Text("오늘은 충전하기 좋은 날씨네요.\n안전 운행 하세요.")
    
    // MARK: - BODY
    var body: some View {
        VStack{
            chargeDescription
                .pretendarText(fontSize: 16)
        }
    }
}

struct MainMapTopDescriptionView_4_Previews: PreviewProvider {
    static var previews: some View {
        MainMapTopDescriptionView_4()
            .previewLayout(.sizeThatFits)
    }
}
