//
//  MapView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/19.
//

import SwiftUI
import MapKit
import Alamofire

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 127.123), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @StateObject var locationManager: LocationViewModel = LocationViewModel()
    @State var zscodeData: ZscodeData?
    @State var chargingStationModelData : ChargingStation?
    @State var userTrackingMode: MapUserTrackingMode = .follow
    
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
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
