//
//  RegionWrapper.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/27.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI

class RegionWrapper: ObservableObject {
    var _region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.748433, longitude: 127.123),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    var region: Binding<MKCoordinateRegion> {
        Binding(
            get: { self._region },
            set: { self._region = $0 }
        )
    }
    @Published var flag = false
}
