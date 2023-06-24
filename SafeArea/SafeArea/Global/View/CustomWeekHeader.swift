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
    
    @State private var checkListAllData: [CheckListModel] = []
    @State private var greenDateStringList: [String] = []
    @State private var yellowDateStringList: [String] = []
    @State private var redDateStringList: [String] = []
    
    @Binding var checkListData: [CheckListModel]
    @Binding var bools: [Bool]
    @Binding var selectedDate: Date
    @Binding var calendarYear: String
    @Binding var calendarMonth: String
    
    @Binding var progress: Double
    
    @State var isFirst = true
    
    var body: some View {
        ZStack {
            ForEach(weekStore.allWeeks) { week in
                VStack{
                    HStack(spacing: 12) {
                        ForEach(0..<7) { index in
                            Button {
                                // Updating Current Day
                                weekStore.currentDate = week.date[index]
                                self.checkListData = DBHelper.shared.readCheckListData(date: formatDate(date: koreanTime(date: weekStore.currentDate)))
                                self.selectedDate = koreanTime(date: weekStore.currentDate)
                                print("selectedDate : \(selectedDate)")
                                print("selectedDate ->  : \(koreanTime(date: weekStore.currentDate))")
                                bindingCheckList(date: weekStore.currentDate)
                            } label: {
                                VStack(spacing: 20) {
                                    Text(weekStore.dateToString(date: koreanTime(date: week.date[index]), format: "EEE"))
                                        .pretendarText(fontSize: 12, fontWeight: .medium)
                                        .foregroundColor(.black)
                                    Circle().frame(width: 35, height: 35).foregroundColor(dateColorFunc(dateStr: weekStore.dateToString(date: koreanTime(date: week.date[index]), format: "yyyy-MM-dd")))
                                        .overlay {
                                            Text(weekStore.dateToString(date: koreanTime(date: week.date[index]), format: "d"))
                                                .pretendarText(fontSize: 16, fontWeight: .medium)
                                                .foregroundColor(.white)
                                        }
                                }
                                .padding(.horizontal, 4)
                                .padding(.vertical, 5)
                                .background(formatDate(date: weekStore.currentDate) == weekStore.dateToString(date: koreanTime(date: week.date[index]), format: "yyyy-MM-dd") ? Color.init(hex: "EEEEEE") : .clear)
                                .cornerRadius(14)
                                .onAppear {
//                                    print("BtnAppear : \(koreanTime(date: week.date[index])) : \(self.selectedDate)")
//                                    print("BtnAppear : \(koreanTime(date: week.date[index])) : \(formatDate(date: weekStore.currentDate))")
//                                    print("BtnAppearBack : \(formatDate(date: koreanTime(date: weekStore.currentDate))) : \(weekStore.dateToString(date: week.date[index], format: "yyyy-MM-dd"))")
                                    print("BtnAppearIndex: \(week.date[index]) : \(formatDate(date: koreanTime(date: weekStore.currentDate)))")
                                    print("BtnAppearIndex: \(week.date[index]) : \(formatDate(date: weekStore.currentDate))")
                                }
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
        .onAppear {
            self.checkListAllData = DBHelper.shared.readCheckListData()
            for data in checkListAllData {
                let count = data.bools.filter { $0 == "1" }.count
                switch count {
                case 0 ..< 4 :
                    redDateStringList.append(data.date)
                    break
                case 4 ..< 8:
                    yellowDateStringList.append(data.date)
                    break
                case 8 ... 10:
                    greenDateStringList.append(data.date)
                    break
                default:
                    print("switch count: \(count)")
                    print("default.count")
                }
                
            }
            calProgress()
            self.selectedDate = koreanTime(date: Date())
        }
        .onChange(of: bools) { newValue in
            
            if !isFirst {
                print("updateNew \(extractLocalDate(from: self.selectedDate))")
                greenDateStringList.removeAll()
                yellowDateStringList.removeAll()
                redDateStringList.removeAll()
                self.checkListAllData = DBHelper.shared.readCheckListData()
                for data in checkListAllData {
                    let count = data.bools.filter { $0 == "1" }.count
                    switch count {
                    case 0 ..< 4 :
                        redDateStringList.append(data.date)
                        break
                    case 4 ..< 8:
                        yellowDateStringList.append(data.date)
                        break
                    case 8 ... 10:
                        greenDateStringList.append(data.date)
                        break
                    default:
                        print("switch count: \(count)")
                        print("default.count")
                    }
                    
                }
            }
            
            calProgress()
            isFirst = false
        }
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
        if checkListData.isEmpty {
            self.bools = [false, false, false, false, false, false, false, false, false, false]
        } else {
            self.bools = decodeBools(self.checkListData.first?.bools ?? "Data none")
        }
    }
}

extension CustomWeekHeader {
    
    func dateColorFunc(dateStr: String) -> Color {
        if greenDateStringList.contains(dateStr) {
            return .safeGreen
        } else if yellowDateStringList.contains(dateStr) {
            return .safeYellow
        } else if redDateStringList.contains(dateStr) {
            return .safeRed
        } else {
            return .safeGray
        }
    }
}

extension CustomWeekHeader {
    func calProgress() {
        progress = 0.5
        for data in greenDateStringList {
            progress += 0.01
            if progress >= 1 {
                return
            }
        }
    }
}
