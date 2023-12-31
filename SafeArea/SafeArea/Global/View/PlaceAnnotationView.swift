//
//  PlaceAnnotationView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/21.
//

import SwiftUI

struct PlaceAnnotationView: View {
    
    
    var charging: ChargingStationAnnotation?
    @Binding var uuidString: String
    let uuid: UUID = UUID()
    @State var isclicked: Bool = false
    @Binding var chargingStationInfo: ChargingStationAnnotation?
    @Binding var isChargingStationInfo: Bool
    var body: some View {
        ZStack {
            VStack {
                if isclicked {
                    Color.white.opacity(0.85).cornerRadius(12)
                        .frame(width: 158, height: 56)
                        .overlay {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(charging?.statNm ?? "데이터 없음")
                                        .pretendarText(fontSize: 16, fontWeight: .semibold)
                                        .lineLimit(1)
                                    //                                        .foregroundColor(Color.red)
                                    
                                    if (charging?.charging == 0 && charging?.ready == 0) {
                                        HStack(spacing: 0) {
                                            Text("모두 이용 중")
                                                .pretendarText(fontSize: 12, fontWeight: .regular)
                                                .foregroundColor(Color.safeRed)
                                                .padding(.trailing)
                                            
                                            
                                            Text("\(charging?.total ?? 0) / \(charging?.total ?? 0)")
                                                .pretendarText(fontSize: 12, fontWeight: .regular)
                                        }
                                    }
                                    
                                    else if (charging?.ready == 0) {
                                        HStack(spacing: 0) {
                                            Text("모두 이용 중")
                                                .pretendarText(fontSize: 12, fontWeight: .regular)
                                                .foregroundColor(Color.safeRed)
                                                .padding(.trailing)
                                            
                                            
                                            Text("\(charging?.charging ?? 0) / \(charging?.total ?? 0)")
                                                .pretendarText(fontSize: 12, fontWeight: .regular)
                                        }
                                    }
                                    else {
                                        HStack {
                                            Text("충전 가능")
                                                .pretendarText(fontSize: 12, fontWeight: .regular)
                                                .foregroundColor(.safeGreen)
                                            
                                            
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
                }
            }
            
            .offset(y: isclicked ? -50 : 0)
        }
        .onTapGesture {
            uuidString = uuid.uuidString
        }
        .onChange(of: uuidString) { newValue in

            if newValue == uuid.uuidString {
                isclicked = true
                isChargingStationInfo = true
                chargingStationInfo = charging
            } else {
                isclicked = false
            }
        }
        
        
    }
}

//struct PlaceAnnotationView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlaceAnnotationView()
//    }
//}
