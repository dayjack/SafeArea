//
//  ChargingStationAnnotationMode.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/22.
//

import Foundation

class ChargingStationAnnotation : ObservableObject, Identifiable {
    
    let id: UUID = UUID()
    var statNm : String?
    var addr: String?
    var lat, lng: String?
    
    var unknownStatus: Int?
    var ready : Int?
    var charging: Int?
    var total: Int?
    
    var distance = 0.0
    
    init(statNm: String? = nil, addr: String? = nil, lat: String? = nil, lng: String? = nil, unknownStatus: Int? = nil, ready: Int? = nil, charging: Int? = nil, total: Int? = nil, distance: Double = 0.0) {
        self.statNm = statNm
        self.addr = addr
        self.lat = lat
        self.lng = lng
        self.unknownStatus = unknownStatus
        self.ready = ready
        self.charging = charging
        self.total = total
    }
}

extension ChargingStationAnnotation: Hashable {
    static func == (lhs: ChargingStationAnnotation, rhs: ChargingStationAnnotation) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
