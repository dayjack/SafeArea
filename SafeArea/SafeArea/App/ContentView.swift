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
    @State var locationViewModel = LocationViewModel()
    @State var zscodeData: ZscodeData?
    @State var chargingStationModelData : ChargingStation?
    @State var weatherData: Weather?
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    @State private var isShowingMessageView = false
    @State private var showingAlert = false
    @State private var iconSelected: IconName = .home
    
    
    
    // MARK: - BODY
    
    
    var body: some View {
//        VStack {
//            Button(action: {
//                showingAlert = true
//            }) {
//                Text("긴급")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .alert("119 긴급 신고를 하시겠습니까?", isPresented: $showingAlert) {
//
//                Button("취소", role: .cancel) {}
//                Button("신고하기", role: .destructive) {isShowingMessageView = true}
//
//            }message: {
//                Text("화재 경보 및 현재 충전소의 위치 정보가\n함께 신고 접수됩니다.")
//            }
//
//
//            // 메시지 보내는 코드
//            .sheet(isPresented: $isShowingMessageView) {
//                MessageComposeView(recipients: ["01040359646"], messageBody: "전기차에서 불났어요")
//            }
//
//
//            // MARK: - 값 체크
//            Text("현재 latitude : \(coordinate?.latitude ?? 0)")
//            Text("현재 longitude : \(coordinate?.longitude ?? 0)")
//
//            Text(self.chargingStationModelData?.items.item.first?.addr ?? "test")
//        }
        ZStack {
            
            switch iconSelected {
            case .guideline:
                MainGuideView()
            case .checklist:
                MainCheckListView()
            case .home:
                MainMapView(locationViewModel: $locationViewModel, zscodeData: $zscodeData, chargingStationModelData: $chargingStationModelData)
            }
            VStack {
                Spacer()
                CustomBottomTabView(iconSelected: $iconSelected)
            }
            .ignoresSafeArea()
        }.ignoresSafeArea()
        .onAppear {
            locationViewModel.requestPermission()
            DispatchQueue.main.async {
                fetchDatass(coordinate ?? .init())
                
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

enum IconName: String {
    case guideline = "icon_guideline"
    case checklist = "icon_checklist"
    case home = "icon_home"
}
