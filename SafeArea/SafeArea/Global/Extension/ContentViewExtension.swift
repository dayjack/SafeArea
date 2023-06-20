//
//  ContentViewExtension.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/20.
//

import SwiftUI
import CoreLocation
import Alamofire

extension ContentView {
    // MARK: - FUNCTION
    func fetchDatass(_ location: CLLocationCoordinate2D) {
        //        print(location.latitude)
        //        print(location.longitude)
        let url = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json"
        let params = ["x" : location.longitude, "y" : location.latitude] as Dictionary
        var chargingStation: ChargingStation?
        var zscodes: String = ""
        let key = Bundle.main.kakaoApiKey!
        
        let headers: HTTPHeaders = ["Authorization": "\(Bundle.main.kakaoApiKey!)"]
        AF.request(url, method: .get ,parameters: params, headers: headers)
            .responseDecodable(of: ZscodeData.self) { response in
                guard let data = response.value else {
                    print("Failed to decode dangerInfoArray")
                    return
                }
                self.zscodeData = data
                
                //파싱방법
                //                print("\(data.documents.first?.code?.prefix(4) ?? "4711")0")
                zscodes = "\(data.documents.first?.code?.prefix(4) ?? "0000")0"
                //                print(zscodes)
                
                fetchChargingStation(zscodes)
                fetchWeathers(location)
            }
    }
    
    func fetchChargingStation(_ zscodes: String) {
        print(zscodes)
//        let chargingUrl = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?numOfRows=9999&pageNo=1&zscode=\(zscodes)&dataType=JSON&serviceKey=\(Bundle.main.chargingAPIKey!)"
        let chargingUrl = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?numOfRows=100&pageNo=1&zscode=\(zscodes)&dataType=JSON&serviceKey=\(Bundle.main.chargingAPIKey!)"
        
        
        print("\(Bundle.main.chargingAPIKey!)")
        
        AF.request(chargingUrl, method: .get).responseDecodable(of: ChargingStation.self) { response in
            //            print(response.value?.items.item.first?.addr)
            guard let data = response.value else {
                print("Failed to decode dangerInfoArray")
                return
            }
            self.chargingStationModelData = data
            
            print(chargingStationModelData?.items.item[0].statNm)
            
        }
    }
    
    func fetchWeathers(_ location: CLLocationCoordinate2D) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let latitude = String(format: "%.2f", location.latitude)
        let longitude = String(format: "%.2f", location.longitude)
        let params = ["lat" : latitude, "lon" : longitude, "appid" : "\(Bundle.main.weatherAPIKey!)"] as Dictionary
        let key = Bundle.main.weatherAPIKey!
        AF.request(url, method: .get ,parameters: params)
            .responseDecodable(of: Weather.self) { response in
                guard let data = response.value else {
                    print("Failed to decode fetchWeather")
                    return
                }
                print(response.value?.weather?.first?.description ?? "날씨 못불러옴")
            }
    }
}
