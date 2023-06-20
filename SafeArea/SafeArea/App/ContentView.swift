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
    
    
    
    
    // MARK: - BODY
    
    
    var body: some View {
        VStack {
            
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

