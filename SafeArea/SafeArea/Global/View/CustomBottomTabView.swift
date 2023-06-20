//
//  CustomBottomTabView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

struct CustomBottomTabView: View {
    
    @Binding var iconSelected: IconName
    
    var body: some View {
            ZStack {
                Color.white
                    .frame(height: 92)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .shadow(radius: 7, x: 0, y: -1)
                HStack(spacing: 57) {
                    
                    Button {
                        iconSelected = .guideline
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
                
                    Image("\(IconName.checklist.rawValue)_unactivated")
                        .frame(width: 73, height: 73)
                        .background(.white)
                        .clipShape(Circle())
                        .offset(x: 0 , y: -41)
                        .shadow(radius: 7)
                        .foregroundColor(.black)
                        .onTapGesture {
                            iconSelected = .home
                        }
                    
                    Button {
                        iconSelected = .checklist
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

