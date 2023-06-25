//
//  OnboardingView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - PROPERTY
    
    @State var pageNm: Int = 1
    @AppStorage("onboarding") var isOnboardingViewActive : Bool = false
    // MARK: - BODY
    var body: some View {
        ZStack() {
            
            TabView {
                Image("onbo_1")
                    .tag(0)
                    .ignoresSafeArea()
                    
                Image("onbo_2")
                    .tag(1)
                    .ignoresSafeArea()
                    .onAppear {
                        pageNm += 1
                    }
                Image("onbo_3")
                    .tag(2)
                    .ignoresSafeArea()
                    .onAppear {
                        pageNm += 1
                    }
                Image("onbo_4")
                    .tag(3)
                    .ignoresSafeArea()
                    .onAppear {
                        pageNm += 1
                    }
                ZStack{
                    Image("onbo_5")
                        .tag(4)
                        .ignoresSafeArea()
                    VStack{
                        Spacer()
                        OnboardingButton()
                            .frame(width: 217, height: 52)
                            .padding(.bottom, 70)
                            .onTapGesture {
                                isOnboardingViewActive = false
                                print("dd")
                            }
                    }
                }
                .onAppear {
                    pageNm += 1
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            VStack(spacing: 0){
                OnboardingIndicator(pageNm: pageNm)
                    .padding(.top, 90)
                    .padding(.bottom, 23)
                Spacer()
            }
        }
        .ignoresSafeArea()
        
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
