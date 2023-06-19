//
//  ChargeDataManager.swift
//  API_Practice
//
//  Created by 신상용 on 2023/06/18.
//

import Foundation

class ChargeDataManager: ObservableObject {
    @Published var chargingStations: ChargingStation?
    
    func fetchDatas(_ file: String) {
        
        
        
        var request = URLRequest(url: URL(string: file)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            
            do {
                let decodeData = try? JSONDecoder().decode(ChargingStation.self, from: data)
                
                DispatchQueue.main.async {
                    self.chargingStations = decodeData!
                    print("데이터\(self.chargingStations!.totalCount)개 JSON to DATA 삽입 완료")
//                    print(decodeData)
                }
            } catch {
                print("Error decoding data: \(error)")
            }
            
            
            
            
            
//            print(String(data: data, encoding: .utf8)!)
//            print(self.chargingStations?.totalCount)
//            print(self.chargingStations?.items.item.count)
        }
        
        task.resume()
        
    }
}
