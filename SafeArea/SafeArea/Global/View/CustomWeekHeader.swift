//
//  CustomWeekHeader.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import SwiftUI

struct CustomWeekHeader: View {
    @Binding var weekStore: WeekStore
    @State private var snappedItem = 0.0
    @State private var draggingItem = 0.0
    
    @State private var greenDateList: [Date] = [
        Date.now
    ]
    @State private var yellowDateList: [Date] = [
        Date(timeIntervalSinceNow: 72000 * 2)
    ]
    @State private var redDateList: [Date] = [
        Date(timeIntervalSinceNow: 72000)
    ]
    
    @Binding var checkListData: [CheckListModel]
    @Binding var bools: [Bool]
    @Binding var selectedDate: Date
    
    var body: some View {
        ZStack {
            ForEach(weekStore.allWeeks) { week in
                VStack{
                    HStack(spacing: 20) {
                        ForEach(0..<7) { index in
                            
                            VStack(spacing: 20) {
                                Text(weekStore.dateToString(date: week.date[index], format: "EEE"))
                                    .pretendarText(fontSize: 14, fontWeight: .semibold)
                                
                                
                                if dateToString(date: greenDateList[0], format: "d") == weekStore.dateToString(date: week.date[index], format: "d")   {
                                    Circle().frame(width: 35, height: 35).foregroundColor(.safeGreen)
                                        .overlay {
                                            Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                                .pretendarText(fontSize: 16, fontWeight: .medium)
                                                .foregroundColor(.white)
                                        }
                                } else if dateToString(date: redDateList[0], format: "d") == weekStore.dateToString(date: week.date[index], format: "d")  {
                                    Circle().frame(width: 35, height: 35).foregroundColor(.safeRed)
                                        .overlay {
                                            Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                                .pretendarText(fontSize: 16, fontWeight: .medium)
                                                .foregroundColor(.white)
                                            
                                        }
                                } else if dateToString(date: yellowDateList[0], format: "d") == weekStore.dateToString(date: week.date[index], format: "d") {
                                    Circle().frame(width: 35, height: 35).foregroundColor(.yellow)
                                        .overlay {
                                            Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                                .pretendarText(fontSize: 16, fontWeight: .medium)
                                                .foregroundColor(.white)
                                        }
                                }
                                else {
                                    Circle().frame(width: 35, height: 35).foregroundColor(.safeGray)
                                        .overlay {
                                            Text(weekStore.dateToString(date: week.date[index], format: "d"))
                                                .pretendarText(fontSize: 16, fontWeight: .medium)
                                                .foregroundColor(.white)
                                        }
                                }
                                
                            }
                            .onTapGesture {
                                // Updating Current Day
                                weekStore.currentDate = week.date[index]
                                print("currentDate :\(weekStore.koreanTime())")
                                self.checkListData = DBHelper.shared.readCheckListData(date: formatDate(date: weekStore.koreanTime()))
                                self.selectedDate = weekStore.koreanTime()
                                bindingCheckList(date: weekStore.koreanTime())
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .frame(maxWidth:.infinity)
                    .background(
                        Rectangle()
                            .fill(.white)
                    )
                }
                .offset(x: myXOffset(week.id), y: 0)
                .zIndex(1.0 - abs(distance(week.id)) * 0.1)
                .padding(.horizontal, 20)
            }
        }
        .frame(maxHeight: .infinity , alignment : .top)
        .padding(.top, 16)
        .gesture(
            DragGesture()
                .onChanged { value in
                    draggingItem = snappedItem + value.translation.width / 400
                }
                .onEnded { value in
                    withAnimation {
                        if value.predictedEndTranslation.width > 0 {
                            draggingItem = snappedItem + 1
                        } else {
                            draggingItem = snappedItem - 1
                        }
                        snappedItem = draggingItem
                        
                        weekStore.update(index: Int(snappedItem))
                    }
                }
        )
    }
}

extension CustomWeekHeader {
    
    func distance(_ item: Int) -> Double {
        return (draggingItem - Double(item)).remainder(dividingBy: Double(weekStore.allWeeks.count))
    }
    
    func myXOffset(_ item: Int) -> Double {
        let angle = Double.pi * 2 / Double(weekStore.allWeeks.count) * distance(item)
        return sin(angle) * 200
    }
    
    func dateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    
}

extension CustomWeekHeader {
    
    func bindingCheckList(date: Date) {
        self.checkListData = DBHelper.shared.readCheckListData(date: formatDate(date: koreanTime(date: date)))
        print("bindingCheckList : \(decodeBools(self.checkListData.first?.bools ?? "Data none"))")
        if checkListData.isEmpty {
            self.bools = [false, false, false, false, false, false, false, false, false, false]
        } else {
            self.bools = decodeBools(self.checkListData.first?.bools ?? "Data none")
        }
    }
}
