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
    @Binding var chargingStationList: [ChargingStationAnnotation]
    //    @State var coordinate: CLLocationCoordinate2D= .init()
    
    @State var isChargingStationCount: Int = 0
    @State var isChargingStationInfo: Bool = false
    @State var chargingStationInfo: ChargingStationAnnotation?
    // MARK: - swiftui_bottom_sheet_drawer
    @State var isFixed = false
    @State var position: BottomSheetPosition = .down(0)
    @State var listOpacity = 0
    
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    
    @State var isListShowing = false
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: (self.chargingStationAnnotation ?? .init())) { charging in
                MapAnnotation(coordinate: .init(latitude: (charging.lat as! NSString).doubleValue, longitude: (charging.lng as! NSString).doubleValue)) {
                    PlaceAnnotationView(charging: charging, chargingStationInfo: $chargingStationInfo, isChargingStationInfo: $isChargingStationInfo, isChargingStationCount : $isChargingStationCount)
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
                                ForEach(chargingStationList, id: \.self) { item in
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 0){
                                            Text(item.statNm ?? "데이터 없음")
                                                .pretendarText(fontSize: 16, fontWeight: .medium)
                                                .padding(.bottom, 8)
                                            HStack {
                                                Text(item.addr ?? "주소 미확인")
                                                    .pretendarText(fontSize: 12, fontWeight: .regular)
                                                Text("  |  ")
                                                
                                                Text(item.distance >= 1000 ? String(format: "%.1fkm", item.distance / 1000) : "\(Int(item.distance))m")
                                                    .pretendarText(fontSize: 12, fontWeight: .medium)
                                                    .onAppear {
                                                        
                                                        let tempcoor = coordinate
                                                        
                                                        let tempLat = tempcoor?.latitude
                                                        let formattedStartLat = String(format: "%.6f", tempLat ?? 0.0)
                                                        
                                                        let tempLng = tempcoor?.longitude
                                                        let formattedStartLng = String(format: "%.6f", tempLng ?? 0.0)
                                                        
                                                        guard let startlat = Double(formattedStartLat), let startlng = Double(formattedStartLng), let endlat = Double(item.lat ?? "0.0"), let endlng = Double(item.lng ?? "0.0") else {
                                                            return
                                                        }
                                                        
                                                        let startLocation = CLLocation(latitude: startlat, longitude: startlng)
                                                        let endLocation = CLLocation(latitude: endlat, longitude: endlng)
                                                        
                                                        calculateDrivingDistance(startLocation: startLocation, endLocation: endLocation) { drivingDistance in
                                                            // Use the drivingDistance value here
                                                            print("Driving distance: \(drivingDistance)")
                                                            item.distance = drivingDistance
                                                        }
                                                        
                                                    }
                                            }
                                            .opacity(0.5)
                                            .padding(.bottom, 9)
                                            
                                            if (item.ready == 0) {
                                                HStack(spacing: 0) {
                                                    Text("모두 이용 중")
                                                        .pretendarText(fontSize: 12, fontWeight: .regular)
                                                        .foregroundColor(Color.safeRed)
                                                        .padding(.trailing)
                                                    Text("\(item.charging ?? 0) / \(item.total ?? 0)")
                                                        .pretendarText(fontSize: 12, fontWeight: .regular)
                                                }
                                            }
                                            else {
                                                HStack {
                                                    Text("충전 가능")
                                                        .pretendarText(fontSize: 12, fontWeight: .regular)
                                                        .foregroundColor(.safeGreen)
                                                    Text("\(item.charging ?? 0) / \(item.total ?? 0)")
                                                        .pretendarText(fontSize: 12, fontWeight: .regular)
                                                }
                                            }
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                    .padding(.top, 18)
                                    .padding(.leading, 24)
                                }
                                Spacer().frame(height: 250)
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
                shift: 252,
                topIndentation: 184
            )
            .onPositionChanged{
                position = $0
                if !position.isDown {
                    withAnimation {
                        listOpacity = 1
                    }
                } else {
                    listOpacity = 1
                    isListShowing = false
                }
            }
            .shadow(color: .black.opacity(0.15), radius: 3.5, x: 0, y: -1)
            .opacity(isFixed || !isListShowing ? 0 : 1)
            
            
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
                        HStack(alignment: .top) {
                            Spacer().frame(width: 48, height: 48).padding(.horizontal, 26)
                            Spacer()
                            Button {
                                isListShowing = true
                            } label: {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 111, height: 36)
                                    .background(.white)
                                    .cornerRadius(18)
                                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
                                    .overlay {
                                        HStack(alignment: .center, spacing: 8) {
                                            Image(systemName: "list.bullet")
                                                .resizable()
                                                .frame(width: 17, height: 12)
                                                .foregroundColor(.safeGreen)
                                            Text("목록 보기")
                                                .pretendarText(fontSize: 14, fontWeight: .regular)
                                                .foregroundColor(.black)
                                        }
                                    }
                            }
                            
                            
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
                            .padding(.horizontal, 26)
                            
                            
                        }
                        .padding(.bottom, 130)
                        
                    }
                    .opacity(isListShowing ? 0 : 1)
                    
                    
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
                
            }
        }
        .onAppear {
            print("LastDance : \(coordinate)")
        }
        
    }
}

//struct MainMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMapView()
//    }
//}
