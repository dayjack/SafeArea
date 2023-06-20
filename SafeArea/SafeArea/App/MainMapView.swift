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
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(userTrackingMode), annotationItems: (self.chargingStationModelData?.items.item ?? .init())) { charging in
            MapAnnotation(coordinate: .init(latitude: (charging.lat as! NSString).doubleValue, longitude: (charging.lng as! NSString).doubleValue)) {
                Circle().foregroundColor(.brown).frame(width: 20, height: 20)
            }
        }
        .ignoresSafeArea()
        .tint(.black)
        .gesture(DragGesture().onChanged { _ in
            userTrackingMode = .none
        })
        .onAppear {
            print("charging count: \(chargingStationModelData?.items.item.count)")
        }
    }
}

//struct MainMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMapView()
//    }
//}
