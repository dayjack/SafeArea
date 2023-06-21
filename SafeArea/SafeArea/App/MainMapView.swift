//
//  MainMapView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI
import CoreLocation
import MapKit

struct MainMapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 127.123), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
    @Binding var locationViewModel: LocationViewModel
    @Binding var zscodeData: ZscodeData?
    @Binding var chargingStationModelData: ChargingStation?
    @Binding var weatherData: Weather?
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    
    var body: some View {
        
        ZStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: (self.chargingStationModelData?.items.item ?? .init())) { charging in
                MapAnnotation(coordinate: .init(latitude: (charging.lat as! NSString).doubleValue, longitude: (charging.lng as! NSString).doubleValue)) {
                    PlaceAnnotationView()
                }
            }
            .ignoresSafeArea()
            .tint(.black)
            .gesture(DragGesture().onChanged { _ in
                userTrackingMode = .none
            })
            
            
            VStack(spacing: 0) {
                
                ZStack {
                    MainMapTopView(locationViewModel: $locationViewModel, zscodeData: $zscodeData, chargingStationModelData: $chargingStationModelData, weatherData: $weatherData)
                    //매개변수 locationViewModel: $locationViewModel, zscodeData: $zscodeData, chargingStationModelData: $chargingStationModelData, weatherData: $weatherData
//                    Image("Union2")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//
////                    print("날씨 데이터 \(self.weatherData!.weather?.first?.description ?? "날씨 안되")")
////                    print("날씨 온도 \(self.weatherData?.main?.temp)")
//
//                    Text("날씨 데이터 \(self.weatherData?.weather?.first?.id ?? 0)")
                    
                }
                
                
                
                Spacer()
            }
            
            
            
        }
        
        
    }
}

//struct MainMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMapView()
//    }
//}
