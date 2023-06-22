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
                
//                ForEach(chargingStation?.items.item ?? .init()) {item in
//                    print("dd")
//                }
                
            }
    }
    
    func fetchChargingStation(_ zscodes: String) {
        print(zscodes)
//        let chargingUrl = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?numOfRows=9999&pageNo=1&zscode=\(zscodes)&dataType=JSON&serviceKey=\(Bundle.main.chargingAPIKey!)"
        let chargingUrl = "https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?numOfRows=500&pageNo=1&zscode=\(zscodes)&dataType=JSON&serviceKey=\(Bundle.main.chargingAPIKey!)"
        
        
        print("\(Bundle.main.chargingAPIKey!)")
        
        AF.request(chargingUrl, method: .get).responseDecodable(of: ChargingStation.self) { response in
            //            print(response.value?.items.item.first?.addr)
            guard let data = response.value else {
                print("Failed to decode dangerInfoArray")
                return
            }
            self.chargingStationModelData = data
            print("dk 데이터 데이터 데이터 데이터 입력완료")
            print(chargingStationModelData?.totalCount)
            print(chargingStationModelData?.items.item[0].statNm)
            
            // MARK: - PROPERTY
            var statNm: String = ""
            var addr: String = ""
            var lat: String = ""
            var lng: String = ""
            var unknownStatus: Int = 0
            var ready: Int = 0
            var charging: Int = 0
            var total: Int = 0
            
            
            
            for item in self.chargingStationModelData?.items.item ?? .init() {
                
                if statNm != (item.statNm!) {     //다를 때 넣어준다.
                    
                    self.chargingStationAnnotation.append(ChargingStationAnnotation(statNm: statNm, addr: addr, lat: lat, lng: lng, unknownStatus: unknownStatus, ready: ready, charging: charging, total: total))
                    
                    statNm = item.statNm!
                    addr = item.addr!
                    lat = item.lat!
                    lng = item.lng!
                    unknownStatus = 0
                    ready = 0
                    charging = 0
                    switch item.stat! {
                    case "2":
                        ready += 1
                    case "3":
                        charging += 1
                    default:
                        unknownStatus += 1
                    }
                    total = 1
                    
                    
                }
                else {
                    
                    switch item.stat! {
                    case "2":
                        ready += 1
                    case "3":
                        charging += 1
                    default:
                        unknownStatus += 1
                    }
                    total += 1
                }
                
                
            }
            if self.chargingStationAnnotation.count != 0 {
                self.chargingStationAnnotation.remove(at: 0)
            }
            self.chargingStationAnnotation.append(ChargingStationAnnotation(statNm: statNm, addr: addr, lat: lat, lng: lng, unknownStatus: unknownStatus, ready: ready, charging: charging, total: total))
            
            for item in self.chargingStationAnnotation ?? .init() {
                print("itemstatNm : \(item.statNm!)")
                print("address : \(item.addr!)")
                print("lat : \(item.lat!)")
                print("lng : \(item.lng!)")
                print("unknownStatus : \(item.unknownStatus!)")
                print("ready : \(item.ready!)")
                print("charging : \(item.charging!)")
                print("total : \(item.total!)")
            }
            
        }
        
        
        
    }
    
    func fetchWeathers(_ location: CLLocationCoordinate2D) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let latitude = String(format: "%.2f", location.latitude)
        let longitude = String(format: "%.2f", location.longitude)
        print("날씨 위도 경도 \(latitude), \(longitude)")
        let params = ["lat" : latitude, "lon" : longitude, "appid" : "\(Bundle.main.weatherAPIKey!)", "units" : "metric"] as Dictionary
        let key = Bundle.main.weatherAPIKey!
        AF.request(url, method: .get ,parameters: params)
            .responseDecodable(of: Weather.self) { response in
                guard let data = response.value else {
                    print("Failed to decode fetchWeather")
                    return
                }
                self.weatherData = data
                print("날씨 데이터 \(self.weatherData!.weather?.first?.description ?? "날씨 안되")")
                print("날씨 데이터2  \(self.weatherData!.weather?.first?.id ?? 2)")
                print("날씨 온도 \(self.weatherData?.main?.temp)")
            }
    }
}
