//
//  CoordinateToZscode.swift
//  API_Practice
//
//  Created by 신상용 on 2023/06/18.
//

import Foundation

class CoordinateToZscodeManager: ObservableObject {
    @Published var zscodeDatas: ZscodeData?
    
    func fetchDatas(_ file: String) {
        
        
        
        var request = URLRequest(url: URL(string: file)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("//카카오 키값 입력하여주세요", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            
            do {
                let decodeData = try? JSONDecoder().decode(ZscodeData.self, from: data)
                
                DispatchQueue.main.async {
                    self.zscodeDatas = decodeData!
                    print("데이터 좌표 JSON to DATA 삽입 완료")
//                    print(self.zscodeDatas?.meta.total_count)
                    
                }
            } catch {
                print("Error decoding data: \(error)")
            }
            
            print(String(data: data, encoding: .utf8)!)
            
        }
        
        task.resume()
        
    }
}
