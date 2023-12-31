//
//  CustomBottomTabView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

struct CustomBottomTabView: View {
    
    @Binding var iconSelected: IconName
    @State var angle: Angle = Angle(degrees: 0)
    @State var imageGrayScale: Double = 0.0
    @State var imageOpacity: Double = 1.0
    
    var body: some View {
            ZStack {
                Color.white
                    .frame(height: 92)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .shadow(radius: 7, x: 0, y: -1)
                HStack(spacing: 57) {
                    
                    Button {
                        iconSelected = .guideline
                        rotateHomeAngle(type: .guideline)
                    } label: {
                        VStack(spacing: 5) {
                            Image(iconSelected == .guideline ? "\(IconName.guideline.rawValue)_activated" : "\(IconName.guideline.rawValue)_unactivated")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 31, height: 31)
                                .padding(.top, 12)
                            Text("가이드라인")
                                .font(.custom("Pretendard-Medium", size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(iconSelected == .guideline ? .safeGreen : .safeGray)
                            Spacer()
                        }
                        .frame(height: 92)
                        .foregroundColor(.black)
                    }
                
                    VStack(spacing: 0) {
                        Circle().foregroundColor(.white)
                            .frame(width: 73, height: 73)
                            .shadow(radius: 7)
                            .overlay {
                                Image("icon_home")
                                    .resizable()
                                    .grayscale(imageGrayScale)
                                    .opacity(imageOpacity)
                                    .frame(width: 65.1, height: 66.3)
                            }
                            .onTapGesture {
                                iconSelected = .home
                                rotateHomeAngle(type: .home)
                            }
                            .rotationEffect(angle)
                    }
                    .offset(y: -41)
                    
                    
                    Button {
                        iconSelected = .checklist
                        rotateHomeAngle(type: .checklist)
                    } label: {
                        VStack(spacing: 5) {
                            Image(iconSelected == .checklist ? "\(IconName.checklist.rawValue)_activated" : "\(IconName.checklist.rawValue)_unactivated")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 31, height: 31)
                                .padding(.top, 12)
                            Text("체크리스트")
                                .font(.custom("Pretendard-Medium", size: 12))
                                .fontWeight(.medium)
                                .foregroundColor(iconSelected == .checklist ? .safeGreen : .safeGray)
                            Spacer()
                        }
                        .frame(height: 92)
                        .foregroundColor(.black)
                    }
                }
            }
        
    }
}

struct CustomBottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottomTabView(iconSelected: .constant(.home))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
         clipShape(RoundedCorner(radius: radius, corners: corners))
     }
}

extension CustomBottomTabView {
    
    
    func rotateHomeAngle(type: IconName) {
        
        switch type {
        case .guideline:
            withAnimation(.easeInOut(duration: 0.25)) {
                self.imageOpacity = 0.4
                self.imageGrayScale = 1
                self.angle = Angle(degrees: -90)
            }
        case .home:
            withAnimation(.easeInOut(duration: 0.25)) {
                self.imageOpacity = 1
                self.imageGrayScale = 0
                self.angle = Angle(degrees: 0)
            }
        case .checklist:
            withAnimation(.easeInOut(duration: 0.25)) {
                self.imageOpacity = 0.4
                self.imageGrayScale = 1
                self.angle = Angle(degrees: 90)
            }
        }
    }
}
