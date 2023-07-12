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
import MapKit
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
    
    // MARK: - 거리 계산
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
    
    
    func deviceSize() -> CGFloat {
        
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            print("Resizing: \(UIScreen.main.nativeBounds.height)")
            
            switch UIScreen.main.nativeBounds.height {
                
            case 2532, 2556: // iPhone 14, iPhone 14 pro, iPhone 13, iPhone 13 Pro
                return 88
            case 2778: // iPhone 13 Pro max
                return 96
            case 2796: // iPhone 14 Pro max
                return 97
            case 2340: // iPhone 13 mini, iPhone 12 mini
                return 84
            case 1334: // iPhnoe SE 3rd generation
                return 82
            case 1792: // iPhone 11
                return 93
            case 2436: // iPhone 11 Pro
                return 84
            case 2688: // iPhone 11 Pro max
                return 93
                
            default:
                return 56
            }
        }
        #endif       
        // 기타 플랫폼에 대한 기본 값 반환
        return 88
    }
    
    func onboardingIndicatorSize() -> CGFloat {
        
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            print("Resizing: \(UIScreen.main.nativeBounds.height)")
            
            switch UIScreen.main.nativeBounds.height {
                
            case 2532, 2556: // iPhone 14, iPhone 14 pro, iPhone 13, iPhone 13 Pro
                return 90
            case 2778: // iPhone 13 Pro max
                return 98
            case 2796: // iPhone 14 Pro max
                return 99
            case 2340: // iPhone 13 mini, iPhone 12 mini
                return 86
            case 1334: // iPhnoe SE 3rd generation
                return 32
            case 1792: // iPhone 11
                return 90
            case 2436: // iPhone 11 Pro
                return 86
            case 2688: // iPhone 11 Pro max
                return 95
                
            default:
                return 56
            }
        }
        #endif
        // 기타 플랫폼에 대한 기본 값 반환
        return 88
    }
    
    func onboardingButtonSize() -> CGFloat {
        
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            print("Resizing: \(UIScreen.main.nativeBounds.height)")
            
            switch UIScreen.main.nativeBounds.height {
                
            case 2532, 2556: // iPhone 14, iPhone 14 pro, iPhone 13, iPhone 13 Pro
                return 70
            case 2778: // iPhone 13 Pro max
                return 70
            case 2796: // iPhone 14 Pro max
                return 70
            case 2340: // iPhone 13 mini, iPhone 12 mini
                return 70
            case 1334: // iPhnoe SE 3rd generation
                return 90
            case 1792: // iPhone 11
                return 70
            case 2436: // iPhone 11 Pro
                return 70
            case 2688: // iPhone 11 Pro max
                return 70
                
            default:
                return 56
            }
        }
        #endif
        // 기타 플랫폼에 대한 기본 값 반환
        return 88
    }
}
