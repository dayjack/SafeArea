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
//            Color.white.frame(width: 100, height: 30)
//                .overlay {
//                    VStack {
//                        Text(charging?.statNm ?? "데이터 없음")
//                            .font(.system(size: 8))
//                        Text("\(charging?.ready ?? 0) / \(charging?.total ?? 0)")
//                            .font(.system(size: 8))
//                    }
//                }
            Image("placeMarker")
        }
        
    }
}

//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}
