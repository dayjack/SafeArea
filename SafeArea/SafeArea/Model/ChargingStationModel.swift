// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)
// https://www.data.go.kr/data/15013115/standard.do
/*
 https://apis.data.go.kr/B552584/EvCharger/getChargerInfo?
 numOfRows=10
 &pageNo=1
 &zscode=47190
 &dataType=JSON&serviceKey=3fN5XeyWbFOVDNr8xbmPsTXRwyTgskEJ6ghj0LFf131CQm3X52Rn%2BCMEwcttKysIzwU%2B45HuKQ4vXWX%2BC8LJ%2BQ%3D%3D
 */

import Foundation

// MARK: - Welcome
class ChargingStation: Codable, ObservableObject {
    let resultMsg: String
    let totalCount: Int
    let items: Items
    let pageNo: Int
    let resultCode: String
    let numOfRows: Int
}

// MARK: - Items
class Items: Codable, ObservableObject {
    let item: [itemss]
}

// MARK: - Item
class itemss: Codable, ObservableObject {
    let statNm,
        statID,
        chgerID,
        chgerType: String?
    let addr: String?
    let location: String?
    let useTime: String?
    let lat, lng: String?
    let busiID: String?
    let bnm, busiNm: String?
    let busiCall: String?
    let stat, statUpdDt, lastTsdt, lastTedt: String?
    let nowTsdt, powerType, output: String?
    let method: String?
    let zcode, zscode: String?
    let kind: String?
    let kindDetail: String?
    let parkingFree: String?
    let note: String?
    let limitYn: String?
    let limitDetail: String?
    let delYn: String?
    let delDetail: String?
    let trafficYn: String?

    
}
