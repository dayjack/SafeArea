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
        .onAppear {
            
            let url = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json"
            let params = ["x" : "129.3252610111111", "y" : "36.0124723151111"] as Dictionary
            let key = Bundle.main.kakaoApiKey!
            print("key : \(key)")
            let headers: HTTPHeaders = ["Authorization": "\(Bundle.main.kakaoApiKey!)"]
            AF.request(url, method: .get ,parameters: params, headers: headers)
                .responseDecodable(of: ZscodeData.self) { response in
                    guard let data = response.value else {
                        print("Failed to decode dangerInfoArray")
                        return
                    }
                    self.zscodeData = data
                    print(response.value?.documents.first?.code ?? "4711000000")
                    print("\(data.documents.first?.code?.prefix(4) ?? "4711")0")
                    
                    let chargingUrl = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?numOfRows=100&pageNo=1&zscode=47110&dataType=JSON&serviceKey=\(Bundle.main.chargingAPIKey!)"
                    
                    let chargingParams = ["numOfRows": "9999", "pageNo": "1", "zscode": "\(data.documents.first?.code?.prefix(4) ?? "4711")0", "dataType": "JSON", "serviceKey": "\(Bundle.main.chargingAPIKey!)"] as Dictionary
                    
                    print("\(Bundle.main.chargingAPIKey!)")
                    
                    AF.request(chargingUrl, method: .get).responseDecodable(of: ChargingStation.self) { response in
                        self.chargingStationModelData = response.value
                        print(self.chargingStationModelData?.items.item.first?.addr)
                    }
                }
            fetchWeather()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
