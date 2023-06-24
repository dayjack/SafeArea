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
    @State var chargingStationAnnotation: [ChargingStationAnnotation] = []
    @State var zscodeData: ZscodeData?
    @State var chargingStationModelData : ChargingStation?
    @State var weatherData: Weather?
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    @State private var isShowingMessageView = false
    @State private var showingAlert = false
    @State private var iconSelected: IconName = .home
    
    @State var chargingStationList: [ChargingStationAnnotation] = []
    
    // MARK: - BODY
    
    
    var body: some View {

        ZStack {
            
                switch iconSelected {
                case .guideline:
                    MainGuideView()
                case .checklist:
                    MainCheckListView()
                case .home:
                    MainMapView(locationViewModel: $locationViewModel, zscodeData: $zscodeData, weatherData: $weatherData, chargingStationAnnotation: $chargingStationAnnotation, chargingStationList: $chargingStationList)
                }
                VStack {
                    HStack {
                        Spacer()
                        EmergencyButtonView(showingAlert: $showingAlert)
                            .padding(.top, 56)
                            .padding(.trailing, 15)
                    }
                    Spacer()
                    CustomBottomTabView(iconSelected: $iconSelected)
                }
            .ignoresSafeArea()
            Color.safeRed.opacity(showingAlert ? 0.25 : 0).allowsHitTesting(false)
            
        }
        .ignoresSafeArea()
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
