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
    
    func decodeBools(_ boolString: String) -> [Bool] {
        
        var temp = boolString
        var resultBools: [Bool]  = []
        
        for boolChar in temp {
            resultBools.append(boolChar == "1" ? true : false)
        }
        
        return resultBools
    }
    
    func formatDate(date: Date) -> String {
        
        var result = ""
        let nowDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        result = dateFormatter.string(from: nowDate)
        return result
    }
    
    func formatDate(dateStr: String) -> Date {
        let dateStr = dateStr
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Input date format
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // Set the timezone to Korea
        
        let convertDate = dateFormatter.date(from: dateStr) // Convert to Date type
        
        
        let timezone = TimeZone.autoupdatingCurrent
        let secondsFromGMT = timezone.secondsFromGMT(for: convertDate ?? Date())
        let localizedDate = convertDate?.addingTimeInterval(TimeInterval(secondsFromGMT))
        return localizedDate ?? Date()
    }
}
