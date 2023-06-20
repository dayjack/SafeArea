//
//  ContentView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/19.
//

import SwiftUI
import Alamofire
import CoreLocation

struct ContentView: View {
    
    // MARK: - PROPERTY
    @StateObject var locationViewModel = LocationViewModel()
    @State var zscodeData: ZscodeData?
    @State var chargingStationModelData : ChargingStation?
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    @State private var isShowingMessageView = false
    @State private var showingAlert = false
    
    
    
    // MARK: - BODY
    
    
    var body: some View {
        VStack {
            Button(action: {
                showingAlert = true
            }) {
                Text("긴급")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .alert("119 긴급 신고를 하시겠습니까?", isPresented: $showingAlert) {
                
                Button("취소", role: .cancel) {}
                Button("신고하기", role: .destructive) {isShowingMessageView = true}

            }message: {
                Text("화재 경보 및 현재 충전소의 위치 정보가\n함께 신고 접수됩니다.")
            }
            
            
            // 메시지 보내는 코드
            .sheet(isPresented: $isShowingMessageView) {
                MessageComposeView(recipients: ["01040359646"], messageBody: "전기차에서 불났어요")
            }
            
            
            // MARK: - 값 체크
            Text("현재 latitude : \(coordinate?.latitude ?? 0)")
            Text("현재 longitude : \(coordinate?.longitude ?? 0)")
            
            Text(self.chargingStationModelData?.items.item.first?.addr ?? "test")
        }
        
        
        
        
        .padding()
        .onAppear {
            locationViewModel.requestPermission()
            DispatchQueue.main.async {
                fetchDatass(coordinate!)
                //                fetchWeather()
                
            }
        }
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

