//
//  PlaceAnnotationView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/21.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    @State var charging: ChargingStationAnnotation?
    
    var body: some View {
        VStack {
            Color.white.opacity(0.75).cornerRadius(12)
                .frame(width: 158, height: 56)
                .overlay {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(charging?.statNm ?? "데이터 없음")
                                .pretendarText(fontSize: 16, fontWeight: .semibold)
                            
                            Text("충전 가능 \(charging?.ready ?? 0) / \(charging?.total ?? 0)")
                                .pretendarText(fontSize: 12, fontWeight: .regular)
                        }
                        .padding(.leading, 10)
                        Spacer()
                    }
                    
                }
                .offset(x: 79, y: 10)
            Image("placeMarker")
        }
        
    }
}

//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}
