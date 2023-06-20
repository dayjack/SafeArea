//
//  PageTabView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI

struct GuidePageTabView: View {
    // MARK: - PROPERTY
    
    let exampleText: [String] = ["1번째", "2번째", "3번째"]
    
    // MARK: - BODY
    var body: some View {
        TabView {
            ForEach(exampleText, id:\.self) { item in
                Text(item)
            } //: LOOP
        } //: TAB
        .background(
            Color(hex: "EAEAEA")
        )
        .tabViewStyle(PageTabViewStyle())
    }
}

// MARK: - PREVIEW
struct GuidePageTabView_Previews: PreviewProvider {
    static var previews: some View {
        GuidePageTabView()
            .previewLayout(.fixed(width: 340, height: 210))
    }
}
