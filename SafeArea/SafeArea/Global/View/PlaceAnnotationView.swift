//
//  PlaceAnnotationView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/21.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    @State var charging: ChargingStationAnnotation?
    @State var isclicked: Bool = false
    
    var body: some View {
        VStack {
            if isclicked {
                Color.white.opacity(0.85).cornerRadius(12)
                    .frame(width: 158, height: 56)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(charging?.statNm ?? "데이터 없음")
                                    .pretendarText(fontSize: 16, fontWeight: .semibold)
                                
                                if (charging?.ready == 0) {
                                    HStack {
                                        Text("모두 이용 중")
                                            .pretendarText(fontSize: 12, fontWeight: .regular)
                                            .foregroundColor(Color.safeRed)
                                        Text("\(charging?.charging ?? 0) / \(charging?.total ?? 0)")
                                            .pretendarText(fontSize: 12, fontWeight: .regular)
                                    }
                                }
                                else {
                                    HStack {
                                        Text("충전 가능")
                                            .pretendarText(fontSize: 12, fontWeight: .regular)
                                        Text("\(charging?.charging ?? 0) / \(charging?.total ?? 0)")
                                            .pretendarText(fontSize: 12, fontWeight: .regular)
                                    }
                                }
                                
                            }
                            .padding(.leading, 10)
                            Spacer()
                        }
                        
                    }
                    .offset(x: 79, y: 10)
            }
            
            ZStack {
                if isclicked {
                    Image("placeMarker_2")
                } else {
                    Image("placeMarker_1")
                }
            } .onTapGesture {
                print("clicked")
                isclicked.toggle()
            }
        }
        .offset(y: isclicked ? -50 : 0)
        
        
    }
}

//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}
