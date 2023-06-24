//
//  MarkerInfoView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/24.
//

//
//  MarkerInfoView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/24.
//

import SwiftUI
import CoreLocation
import MapKit

struct MarkerInfoView: View {
    // MARK: - PROPERTY
    @Binding var charging: ChargingStationAnnotation?
    @State var locationViewModel = LocationViewModel()
    var coordinate: CLLocationCoordinate2D? {
        locationViewModel.lastSeenLocation?.coordinate
    }
    @State var distance = "0m"
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading, spacing: 0){
                    Text(charging?.statNm ?? "데이터 없음")
                        .pretendarText(fontSize: 16, fontWeight: .medium)
                        .padding(.bottom, 8)
                    HStack {
                        Text(charging?.addr ?? "주소 미확인")
                            .pretendarText(fontSize: 12, fontWeight: .regular)
                        Text("  |  ")
                        Text(distance)
                            .pretendarText(fontSize: 12, fontWeight: .medium)
                    }
                    .opacity(0.5)
                    .padding(.bottom, 9)
                    
                    if (charging?.ready == 0) {
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
                            Text("\(charging?.charging ?? 0) / \(charging?.total ?? 0)")
                                .pretendarText(fontSize: 12, fontWeight: .regular)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 18)
            .padding(.leading, 24)
            .onAppear {
                guard let endlat = Double(charging?.lat ?? "0.0"), let endlng = Double(charging?.lng ?? "0.0") else {
                    return
                }
                
                let startLocation = CLLocation(latitude: 36.0228141, longitude: 129.3164021)
                let endLocation = CLLocation(latitude: endlat, longitude: endlng)
                
                calculateDrivingDistance(startLocation: startLocation, endLocation: endLocation) { drivingDistance in
                    // Use the drivingDistance value here
                    print("Driving distance: \(drivingDistance)")
                    
                    if drivingDistance >= 1000 {
                        distance = "\(drivingDistance / 1000)km"
                    } else {
                        distance = "\(drivingDistance)m"
                    }
                    
                    print("distance : \(coordinate?.latitude ?? 0.0) , \(coordinate?.longitude ?? 0.0)")
                    print("distance : \(charging?.lat ?? "0.0") , \(charging?.lng ?? "0.0")")
                    print("distance : \(drivingDistance)")
                    print("distance : \(distance)")
                }
            }
        } //: ZSTACK
    }
    
    func calculateDrivingDistance(startLocation: CLLocation, endLocation: CLLocation, completion: @escaping (CLLocationDistance) -> Void) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: endLocation.coordinate))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                // Handle error
                print(error)
                completion(0.0) // Return 0.0 if an error occurred
                return
            }
            print("distance func: \(route.distance)")
            completion(route.distance)
        }
    }
}
