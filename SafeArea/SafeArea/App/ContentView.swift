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
                    EmergencyButtonView(showingAlert: $showingAlert, chargingStationList: $chargingStationList, weatherData: $weatherData)
                        .padding(.top, emergencyBtnPaddingTop())
                        .padding(.trailing, emergencyBtnPaddingTrailng())
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

extension ContentView {
    
    func emergencyBtnPaddingTop() -> CGFloat {
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2532, 2556: // iPhone 14, iPhone 14 pro, iPhone 13, iPhone 13 Pro, iPhone 12, iPhone 12 Pro
                return 56
            case 2778: // iPhone 13 Pro max, iPhone 12 Pro max
                return 60.96
            case 2796: // iPhone 14 Pro max
                return 61
            case 2340: // iPhone 13 mini, iPhone 12 mini
                return 54
            case 1334: // iPhone SE 3rd generation
                return 53
            case 1792: // iPhone 11
                return 59
            case 2436: // iPhone 11 Pro
                return 54
            case 2688: // iPhone 11 Pro max
                return 59
                
            default:
                return 56
            }
        }
#endif
        return 0.0
    }
    
    func emergencyBtnPaddingTrailng() -> CGFloat {
#if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2532, 2556: // iPhone 14, iPhone 14 Pro, iPhone 13, iPhone 13 Pro
                return 15
            case 2778: // iPhone 13 Pro, iPhone 14 Plus
                return 16
            case 2796: // iPhone 14 Pro max
                return 15
            case 2340: // iPhone 13 mini, iPhone 12 mini
                return 14
            case 1334: // iPhnoe SE 3rd generation
                return 15
            case 1792: // iPhone 11
                return 16
            case 2436: // iPhone 11 Pro
                return 15
            case 2688: // iPhone 11 Pro max
                return 16
                
            default:
                return 15
            }
        }
#endif
        return 0.0
    }
}
