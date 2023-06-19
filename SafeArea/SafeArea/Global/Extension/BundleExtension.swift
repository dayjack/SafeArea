//
//  BundleExtension.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/19.
//

import Foundation
import SwiftUI

extension Bundle {
    
    var kakaoApiKey: String? {
        guard let file = self.path(forResource: "Secrets", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["KakaoRestAPIKey"] as? String else {
            return nil
        }
        return key
    }
    
}
