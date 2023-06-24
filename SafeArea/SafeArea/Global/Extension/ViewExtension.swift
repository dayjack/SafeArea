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
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.locale = Locale(identifier: "ko_KR")
            df.timeZone = TimeZone(abbreviation: "KST")
            df.dateFormat = "yyyy-MM-dd"
            return df
        }()
        let formattedDate = dateFormatter.string(from: date)
        print("현재시간 formatDate: \(koreanTime(date: date))")
        print("현재시간 formattedDate: \(formattedDate)")
        return formattedDate
    }
    
    func koreanTime(date: Date) -> Date {
        
        let calendar = Calendar(identifier: .gregorian)
        let timezone = TimeZone(identifier: "Asia/Seoul")
        
        var components = calendar.dateComponents(in: timezone!, from: date)
        components.hour! += 9 // UTC에서 한국 표준시로 변환
        
        let convertedDate = calendar.date(from: components)!
        return convertedDate
    }
    
    func extractLocalDate(from date: Date) -> String {
        
        let formatter = DateFormatter()
        let calendar = Calendar.current
        let timeZone = TimeZone(identifier: "UTC") // UTC 시간대로 설정하고자 한다면 "UTC"를 사용

        formatter.calendar = calendar
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)

        return formattedDate
    }
}
