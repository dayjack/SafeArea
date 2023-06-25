//
//  MainApp.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/25.
//

import SwiftUI
import CoreLocation

struct MainApp: View {
    @State var locationViewModel = LocationViewModel()
    @AppStorage("onboarding") var isOnboarindViewActive: Bool = true
    
    var body: some View {
        ZStack{
            if isOnboarindViewActive{
                
                OnboardingView()
            }else {
                ContentView()
                    
            }
        }
        .onAppear {
            _ = DBHelper.shared.createDB()
            DBHelper.shared.createCheckListTable()
        }
    }
}

struct MainApp_Previews: PreviewProvider {
    static var previews: some View {
        MainApp()
    }
}
