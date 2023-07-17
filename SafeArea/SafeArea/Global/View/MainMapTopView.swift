//
//  MainMapTopView.swift
//  SafeArea
//
//  Created by 신상용 on 2023/06/21.
//

import SwiftUI

struct MainMapTopView: View {
    // MARK: - PROPERTY
    @Binding var locationViewModel: LocationViewModel
    @Binding var zscodeData: ZscodeData?
    @Binding var weatherData: Weather?
    
    @State var weatherid: Int = 501
    @State var address: String = "경상북도 포항시 남구 지곡동"
    @State var temp: Int = 30
    
    
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("Union2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment:.center, spacing: 0) {
                    switch weatherData?.weather?.first?.id {
                    case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232 :
                        Image("thunder")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 300, 301, 302, 310, 311, 312, 313, 314, 321, 500, 501, 502, 503, 504, 511, 520, 521, 522, 531, 900, 901, 902, 960, 961, 962:
                        Image("rain")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 600, 601, 602, 611, 612, 615, 616, 620, 621, 622, 906:
                        Image("snow")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 701, 711, 721, 731, 741, 751, 761, 762:
                        Image("fog")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 800, 803, 951:
                        Image("sun")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 801, 802:
                        Image("cloud+sun")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 804:
                        Image("cloud")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 904:
                        Image("hot")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    case 771, 781, 903, 905, 952, 953, 954, 955, 956, 957, 958, 959:
                        Image("wind")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    default:
                        Image("whiteRec")
                            .resizable()
                            .frame(width: 38, height: 38)
                            .padding(.trailing, 6)
                    }
                    
                    //                    Image("cloudrain")
                    //                        .resizable()
                    //                        .frame(width: 38, height: 38)
                    //                        .padding(.trailing, 6)
                    Text("\(Int(weatherData?.main?.temp ?? 0))°")
                        .pretendarText(fontSize: 28, fontWeight: .regular)
                        .padding(.trailing, 4)
                    RoundedRectangle(cornerRadius: 1)
                        .frame(width: 1.5, height: 16)
                        .padding(.trailing, 8)
                    Text(zscodeData?.documents.first?.address_name ?? "")
                        .pretendarText(fontSize: 12, fontWeight: .medium)
                        .foregroundColor(Color.black.opacity(0.5))
                    
                }
                .padding(.bottom, 8)
                
                switch weatherData?.weather?.first?.id {
                case 300, 301, 302, 310, 311, 312, 312, 313, 314, 321, 500, 501, 502, 503, 504, 520, 521, 522, 531, 612, 781, 900, 901, 902, 960, 961, 962, 600, 601, 602, 611, 612, 615, 616, 620, 621, 622 :
                    MainMapTopDescriptionView_1()
                        .padding(.leading, 3)
                    
                case 904 :
                    MainMapTopDescriptionView_2()
                        .padding(.leading, 3)
                    
                case 200, 201, 202, 210, 211, 212, 221, 230, 231, 232:
                    MainMapTopDescriptionView_3()
                        .padding(.leading, 3)
                    
                case 511, 701, 711, 721, 731, 741, 751, 761, 762, 771, 800, 801 ,802, 803, 804, 903, 905, 906, 951, 952, 953, 954, 955, 956, 957, 958, 959:
                    MainMapTopDescriptionView_4()
                        .padding(.leading, 3)
                default:
                    Text("")
                        .pretendarText(fontSize: 16)
                        .padding(.leading, 3)
                }
                
                
                
            }
            .padding(.top, 54)
            .padding(.leading, 21)
            .onAppear {
                print("weather Data : \(weatherData?.weather?.first?.id)")
            }
//            HStack {
//                Spacer()
//                EmergencyButtonView()
//                    .padding(.top, 56)
//                    .padding(.trailing, 15)
//            }
            
        }
    }
    
}

//struct MainMapTopView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMapTopView()
//            .previewLayout(.sizeThatFits)
//    }
//}
