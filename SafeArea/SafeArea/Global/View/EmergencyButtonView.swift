//
//  EmergencyButtonView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI

struct EmergencyButtonView: View {
    // MARK: - PROPERTY
    @State private var isShowingMessageView = false
    @State private var showingAlert = false
    @State private var isPressing = false
    @State private var timer: Timer? = nil
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    // MARK: - BODY
    var body: some View {
        ZStack{
            Image("emergencyButton")
                .resizable()
                .frame(width: 88, height: 88)
                .shadow(color: Color.black.opacity(0.25), radius: 10, x: 0, y: 4)
        }
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
                        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                            isPressing = false
                            timer?.invalidate()
                            print("Timeout - Press Duration Less Than 3 Seconds")
                        }
                        print("Long Press Started")
                    }
                }
        )
        .alert("119 긴급 신고를 하시겠습니까?", isPresented: $showingAlert) {
            Button("취소", role: .cancel) {}
            Button("신고하기", role: .destructive) {isShowingMessageView = true}
        }message: {
            Text("화재 경보 및 현재 충전소의 위치 정보가\n함께 신고 접수됩니다.")
        }
        .sheet(isPresented: $isShowingMessageView) {
            MessageComposeView(recipients: ["01040359646"], messageBody: "전기차에서 불났어요")
        }
        
        
        //        .gesture(
        //            LongPressGesture(minimumDuration: 3)
        //                .onEnded{ _ in
        //                    isPressing = false
        //                    print("Long Press Ended")
        //                }
        //                .onChanged{ value in
        //
        //                    if !isPressing {
        //                        isPressing = true
        //                        print("Long Press Started")
        //                    }
        //                }
        //        )
        
        
        
        //        .onTapGesture {
        //            showingAlert = true
        //        }
        //        .alert("119 긴급 신고를 하시겠습니까?", isPresented: $showingAlert) {
        //            Button("취소", role: .cancel) {}
        //            Button("신고하기", role: .destructive) {isShowingMessageView = true}
        //
        //        }message: {
        //            Text("화재 경보 및 현재 충전소의 위치 정보가\n함께 신고 접수됩니다.")
        //        }
        //
        //        .sheet(isPresented: $isShowingMessageView) {
        //            MessageComposeView(recipients: ["01040359646"], messageBody: "전기차에서 불났어요")
        //        }
        
    }
}

// MARK: - PREVIEW
struct EmergencyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyButtonView()
            .previewLayout(.sizeThatFits)
    }
}
