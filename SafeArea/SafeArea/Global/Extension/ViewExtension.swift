////
////  ViewExtension.swift
////  SafeArea
////
////  Created by ChoiYujin on 2023/06/19.
////
//
import Alamofire
import Foundation
import SwiftUI
import CoreLocation
//
extension View {
 
    func fetchWeather() {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let params = ["lat" : 36.11, "lon" : 120.99, "appid" : "\(Bundle.main.weatherAPIKey!)"] as Dictionary
        let key = Bundle.main.weatherAPIKey!
        print("key : \(key)")
        AF.request(url, method: .get ,parameters: params)
            .responseDecodable(of: Weather.self) { response in
                guard let data = response.value else {
                    print("Failed to decode fetchWeather")
                    return
                }
                print(response.value?.weather?.first?.description ?? "날씨 못불러옴")
            }
    }
    
    func pretendarText(fontSize: CGFloat = 22, fontWeight: Font.Weight = .medium) -> some View {
        modifier(PretendardTextModifier(fontSize: fontSize, fontWeight: fontWeight))
    }
    
    func encodeBools(bools: [Bool]) -> String {
        
        var temp = bools
        var resultString = ""
        
        for boolItem in bools {
            resultString.append(boolItem ? "1" : "0")
        }
        
        return resultString
    }
    
    func decodeBools() -> String {
        return ""
    }
        
}
