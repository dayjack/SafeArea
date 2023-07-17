//
//  EmergencyButtonView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI
import Alamofire


struct EmergencyButtonView: View {
    // MARK: - PROPERTY
    @State private var isShowingMessageView = false
    @Binding var showingAlert: Bool
    @State private var isPressing = false
    @State private var timer: Timer? = nil
    @Binding var chargingStationList: [ChargingStationAnnotation]
    @Binding var weatherData: Weather?
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    // MARK: - BODY
    var body: some View {
        ZStack{
            Image("emergencyButton")
                .resizable()
                .frame(width: 88, height: 88)
                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 4)
                .overlay(
                    Circle()
                        .stroke(Color(hex: "EC583E"), lineWidth: 2)
                        .frame(width: isPressing ? 115 : 85, height: isPressing ? 115 : 85)
                )
                .overlay(
                    Circle()
                        .stroke(Color(hex: "EC583E"), lineWidth: 2)
                        .frame(width: isPressing ? 108 : 78, height: isPressing ? 108 : 78)
                )
                .overlay(
                    Circle()
                        .stroke(Color(hex: "EC583E"), lineWidth: 2)
                        .frame(width: isPressing ? 101 : 71, height: isPressing ? 101 : 71)
                )
        }
        .animation(Animation.easeOut(duration: 3), value: isPressing)
        .gesture(
            LongPressGesture(minimumDuration: 3)
                .onEnded { _ in
                    timer?.invalidate()
                    isPressing = false
                    generator.impactOccurred()
                    showingAlert = true
                    print("Long Press Ended")
                }
                .onChanged { value in
                    if !isPressing {
                        isPressing = true
                        generator.impactOccurred()
                        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                            isPressing = false
                            timer?.invalidate()
                            print("Long Timeout - Press Duration Less Than 3 Seconds")
                        }
                        
                        
                        print("Long Press Started")
                    }
                }
        )
        .alert("119 긴급 신고를 하시겠습니까?", isPresented: $showingAlert) {
            Button("취소", role: .cancel) {}
            Button("신고하기", role: .destructive) {
                isShowingMessageView = true
                print("dd \(weatherData?.weather![0].id)")
                
                /*
                 var chgerID: String = ""
                 var chgerType: String = ""
                 */
                
                var url = URL(string: "http://35.72.228.224/safeArea/insertEVCarData.php")!
                let dangerparams =
                ["temp" : weatherData?.main?.temp, "weatherStatus" : weatherData?.weather![0].id, "chargeName" : "\(chargingStationList[0].statNm!)", "chargeAddress": "\(chargingStationList[0].addr!)", "humidity" : weatherData?.main?.humidity, "pressure" : weatherData?.main?.pressure, "chgerID" : chargingStationList[0].chgerID, "chgerType" : chargingStationList[0].chgerType] as Dictionary
                
                AF.request(url, method: .get, parameters: dangerparams).responseString {
                    print($0)
                }
                
            }
        }message: {
            Text("화재 경보 및 현재 충전소의 위치 정보가\n함께 신고 접수됩니다.")
        }
        .sheet(isPresented: $isShowingMessageView) {
            MessageComposeView(recipients: ["01087918713"], messageBody: "[안전충전 App 발신]\n \n화재 신고합니다. \n \n- 충전소 이름 :  \(chargingStationList[0].statNm!), \n- 현 위치 : \(chargingStationList[0].addr!), \n- 주위에 \(chargingStationList[0].charging!)대의 전기차 충전 중 ")
        }
        
    }
}

// MARK: - PREVIEW
//struct EmergencyButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmergencyButtonView(showingAlert: .constant(false))
//            .previewLayout(.sizeThatFits)
//    }
//}
