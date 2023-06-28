//
//  SplashScreenView.swift
//  Launch_prac1
//
//  Created by 신상용 on 2023/04/27.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.7
    @State private var opacity = 0.5
    @State private var rotationAngle: Angle = .degrees(0)
    
    var body: some View {
        if isActive {
            MainApp()
        } else {
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image("launchIcon")
                        .rotationEffect(rotationAngle)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).delay(0.2)) // 스프링 애니메이션 설정
                        .onAppear {
                            rotationAngle = .degrees(180) // 회전 각도 업데이트
                        }
                    Spacer()
                }
                Spacer()
            }
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.43, green: 0.8, blue: 0.42), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.31, green: 0.68, blue: 0.55), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.07, y: 0),
                    endPoint: UnitPoint(x: 0.9, y: 1)
                )
            )
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    withAnimation {
                        self.isActive = true
                    }
                    
                }
            }
        }
    }
    
    
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
