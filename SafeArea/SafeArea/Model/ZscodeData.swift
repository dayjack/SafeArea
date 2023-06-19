//
//  ZscodeData.swift
//  API_Practice
//
//  Created by 신상용 on 2023/06/18.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let zscodeData = try? JSONDecoder().decode(ZscodeData.self, from: jsonData)

import Foundation

// MARK: - ZscodeData
class ZscodeData: Codable, ObservableObject {
    let meta: Meta
    let documents: [Document]
}

// MARK: - Document
class Document: Codable, ObservableObject {
    let region_type, code, address_name, region_1depth_name: String?
    let region_2depth_name, region_3depth_name, region_4depth_name: String?
    let x, y: Double?
}

// MARK: - Meta
class Meta: Codable, ObservableObject {
    let total_count: Int
}

