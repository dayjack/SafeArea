//
//  OnboardingView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingView: View {
    @State var pageNm: Int = 1
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = false
    
    var body: some View {
        ZStack {
            TabView(selection: $pageNm) { // selection 매개변수로 현재 페이지 번호 추적
                Image("onbo_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .tag(1) // 페이지 번호 태그
                
                Image("onbo_2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .tag(2)
                
                Image("onbo_3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .tag(3)
                
                Image("onbo_4")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                    .tag(4)
                
                ZStack {
                    Image("onbo_5")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        OnboardingButton()
                            .frame(width: 217, height: 52)
                            .padding(.bottom, onboardingButtonSize())
                            .onTapGesture {
                                 isOnboardingViewActive = false
                                print("dd")
                            }
                    }
                }
                .tag(5)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            
            VStack(spacing: 0) {
                OnboardingIndicator(pageNm: $pageNm)
                    .padding(.top, onboardingIndicatorSize())
                    .padding(.bottom, 23)
                Spacer()
            }
            .animation(.easeIn, value: pageNm)
        }
        .ignoresSafeArea()
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
