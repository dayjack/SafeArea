//
//  MainMapView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI
import CoreLocation
import MapKit
import swiftui_bottom_sheet_drawer

struct MainMapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 127.123), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var userTrackingMode: MapUserTrackingMode = .follow
    @Binding var locationViewModel: LocationViewModel
    @Binding var zscodeData: ZscodeData?
    @Binding var weatherData: Weather?
    @Binding var chargingStationAnnotation: [ChargingStationAnnotation]
    
    @State var isChargingStationInfo: Bool = false
    @State var chargingStationInfo: ChargingStationAnnotation?
    // MARK: - swiftui_bottom_sheet_drawer
    @State var isFixed = false
    @State var position: BottomSheetPosition = .down(0)
    @State var listOpacity = 0
    
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: (self.chargingStationAnnotation ?? .init())) { charging in
                MapAnnotation(coordinate: .init(latitude: (charging.lat as! NSString).doubleValue, longitude: (charging.lng as! NSString).doubleValue)) {
                    PlaceAnnotationView(charging: charging, chargingStationInfo: $chargingStationInfo, isChargingStationInfo: $isChargingStationInfo)
                }
            }
            .ignoresSafeArea()
            .tint(.safeRed)
            .gesture(DragGesture().onChanged { _ in
                userTrackingMode = .none
            })
                BottomSheet(
                    content:
                            ZStack {
                                Color.white
                                    .cornerRadius(20)
                                    .offset(y: -14)
                                VStack {
                                    
                                    List {
                                        
                                        ForEach(0..<5) { _ in
                                            VStack(alignment: .leading, spacing: 0) {
                                                Text("충전소")
                                                    .pretendarText(fontSize: 16, fontWeight: .medium)
                                                    .padding(.bottom, 8)
                                                Text("라아ㅓㅗㄹ어ㅏㅗㅁ라ㅓㅗㅇ러ㅗ아로아ㅓ로아ㅓㅗㄹ")
                                                    .pretendarText(fontSize: 16, fontWeight: .medium)
                                                    .padding(.bottom, 7)
                                                Text("포항시 남구 지곡동")
                                                    .pretendarText(fontSize: 12, fontWeight: .medium)
                                                    .foregroundColor(Color.init(hex: "808080"))
                                            }
                                        }
                                    }
                                    .listStyle(.plain)
                                    .opacity(Double(listOpacity))
                                    
                                }
                                .padding(.leading, 4)
                                .padding(.vertical, 26)
                                .opacity(isFixed ? 0 : 1)
                            }
                        .shadow(color: .black.opacity(0), radius: 0, x: 0, y: 0)
                    ,
                    shift: 154,
                    topIndentation: 184
                )
            .onPositionChanged{
                position = $0
                if !position.isDown {
                    withAnimation {
                        listOpacity = 1
                    }
                } else {
                    listOpacity = 0
                }
            }
            .shadow(color: .black.opacity(0.15), radius: 3.5, x: 0, y: -1)
            .opacity(isFixed ? 0 : 1)
            
            
            VStack {
                Spacer()
                Color.white.frame(height: 154)
                
            }
            .ignoresSafeArea()
            .opacity(isFixed ? 1 : 0)
            
            VStack(spacing: 0) {
                
                ZStack {
                    MainMapTopView(locationViewModel: $locationViewModel, zscodeData: $zscodeData, weatherData: $weatherData)
                    
                }
                
                
                
                Spacer()
                if !isChargingStationInfo {
                    ZStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation(.easeIn(duration: 2)) {
                                    userTrackingMode = .follow
                                }
                                
                            } label: {
                                Circle().frame(width: 48, height: 48)
                                    .foregroundColor(.white)
                                    .overlay {
                                        
                                        Image(systemName: "location.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 18.4, height: 18.4)
                                            .foregroundColor(.black)
                                        
                                    }
                                    .shadow(radius: 4, x: 0 , y: 1)
                            }
                            .opacity(position.isDown ? 1 : 0)
                            
                        }
                        .padding(.horizontal, 26)
                        .padding(.bottom, 180)
                        
                    }
                    
                }
                
            }
            
            ZStack{
                if isChargingStationInfo {
                    VStack {
                        Spacer()
                        MarkerInfoView(charging: $chargingStationInfo, coordinate2d: coordinate ?? .init())
                            .frame(width: 391, height: 210)
                            .background(
                                Color.white
                            )
                        
                    }
                }
            }
            
        } //: ZSTACK
        
        
    }
}

//struct MainMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMapView()
//    }
//}
