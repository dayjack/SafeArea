//
//  CustomBottomTabView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

struct CustomBottomTabView: View {
    var body: some View {
        ZStack {
            
            
            Color.white
                .frame(height: 92)
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(radius: 7, x: 0, y: -1)
            HStack(spacing: 57) {
                
                Button {
                    //
                } label: {
                    Text("d")
                        .foregroundColor(.black)
                }
                Button {
                    
                } label: {
                    Text("d")
                        .frame(width: 73, height: 73)
                        .background(.white)
                        .clipShape(Circle())
                        .offset(x: 0 , y: -41)
                        .shadow(radius: 7)
                        .foregroundColor(.black)
                }
                
                Button {
                    
                } label: {
                    Text("d")
                        .foregroundColor(.black)
                }

                
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.opacity(0.4))
        .ignoresSafeArea()
    }
}

struct CustomBottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBottomTabView()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
         clipShape(RoundedCorner(radius: radius, corners: corners))
     }
}
