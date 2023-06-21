//
//  MainCheckListView.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

struct MainCheckListView: View {
    
    @State private var progress = 0.5
    @State private var isOn = false
    
    let checkList: [String] = [
        "🔋 배터리 충전 상태 확인",
        "🔌 충전 케이블 및 충전 포트 점검",
        "🛞 타이어 공기압 확인",
        "타이어 마모 및 이상 여부 확인",
        "브레이크 작동 확인",
        "🛟 운전자 보호 장비 점검 (안전벨트, 에어백 등)",
        "🔨 비상 도구 확인 (예비 타이어, 삼각대, 양도구 등)",
        "⛽️ 충전소 위치 및 충전 시간 확인",
        "주행 거리와 배터리 잔량 관리",
        "🚧 주행 전 차량 주위 안전 점검"
    ]
    
    @State var bools: [Bool] = [false, false, false, false, false, false, false, false, false, false]
    @State var checkListData: [CheckListModel] = []
    @State var selectedDate: Date = Date.now
    @State var weekStore = WeekStore()
    @State var calendarYear = "2023"
    @State var calendarMonth = "07"
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                    .frame(height: 74)
                    .frame(maxWidth: .infinity)
                Text("전기차 안전 체크리스트")
                    .pretendarText(fontSize: 24, fontWeight: .semibold)
                Text("오늘 하루 나의 차는 안전한가요?")
                    .pretendarText(fontSize: 14, fontWeight: .medium)
                    .padding(.bottom, 45)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("나의 안전지수 100% 충전 챌린지")
                        .pretendarText(fontSize: 16, fontWeight: .semibold)
                    HStack(spacing: 9) {
                        Gauge(value: progress) {
                            EmptyView()
                        }
                        .frame(width: 190)
                        .frame(height: 10)
                        .tint(.safeGreen)
//                        .gaugeStyle(.accessoryLinearCapacity)
                        
                        Text("50%")
                            .frame(height: 19)
                            .pretendarText(fontSize: 12, fontWeight: .medium)
                    }
                }
                .padding(.vertical, 11)
                .padding(.horizontal, 18)
                .background(Color.safeGreen.opacity(0.15))
                .cornerRadius(11)
                
                
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 24)
            
            // MARK: - Calendar 들어갈 자리
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                    .frame(height: 5)
                    .frame(maxWidth: .infinity)
                Text("\(calendarYear)년 \(calendarMonth)월")
                    .pretendarText(fontSize: 16, fontWeight: .semibold)
                    .padding(.leading, 8)
                Color.clear.overlay {
                    CustomWeekHeader(weekStore: $weekStore, checkListData: $checkListData, bools: self.$bools, selectedDate: $selectedDate,calendarYear: $calendarYear, calendarMonth: $calendarMonth)
                }
                .frame(height: 68)
                .padding(.bottom, 20)
                Divider()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            Spacer()
                .frame(height: 21)
                .frame(maxWidth: .infinity)
            // MARK: - 체크 리스트
                VStack(alignment: .leading, spacing: 13) {
                    Spacer().frame(height: 1).frame(maxWidth: .infinity)
                    ForEach(checkList.indices, id: \.self) { index in
                        let item = checkList[index]
                        Toggle(isOn: $bools[index]) {
                            Text(item)
                                .pretendarText(fontSize: 16, fontWeight: .regular)
                                .foregroundColor(.black)
                        }
                        .frame(height: 16)
                        .toggleStyle(CheckboxStyle())
                    }
                    .ignoresSafeArea()
                    .onChange(of: bools) { newValue in
                        print("bools change : \(newValue)")
                        DBHelper.shared.updateCheckListData(bools: encodeBools(bools: newValue), date: formatDate(date: koreanTime(date: weekStore.currentDate)))
                    }
                    .onChange(of: selectedDate) { newValue in
                        bindingCheckList(date: newValue)
                        self.calendarYear = weekStore.dateToString(date: weekStore.koreanTime(), format: "yyyy")
                        self.calendarMonth = weekStore.dateToString(date: weekStore.koreanTime(), format: "MM")
                    }
                    
                }
            .padding(.leading, 24)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .ignoresSafeArea(.all)
        .onAppear {
            self.checkListData = DBHelper.shared.readCheckListData(date: formatDate(date: koreanTime(date: Date.now)))
            print("현재시간: \(koreanTime(date: Date.now))")
            self.selectedDate = koreanTime(date: Date.now)
            bindingCheckList(date: koreanTime(date: Date.now))
            self.calendarYear = weekStore.dateToString(date: weekStore.koreanTime(), format: "yyyy")
            self.calendarMonth = weekStore.dateToString(date: weekStore.koreanTime(), format: "MM")
        }
    }
    
}

struct MainCheckListView_Previews: PreviewProvider {
    static var previews: some View {
        MainCheckListView()
    }
}

extension MainCheckListView {
    
    func bindingCheckList(date: Date) {
        print("현재시간 in bind : \(date)")
        print("현재시간 fotmat : \(formatDate(date: date))")
        self.checkListData = DBHelper.shared.readCheckListData(date: formatDate(date: date))
        print("bindingCheckList : \(decodeBools(self.checkListData.first?.bools ?? "Data none")), \(date)")
        if checkListData.isEmpty {
            self.bools = [false, false, false, false, false, false, false, false, false, false]
        } else {
            self.bools = decodeBools(self.checkListData.first?.bools ?? "Data none")
        }
    }
}
