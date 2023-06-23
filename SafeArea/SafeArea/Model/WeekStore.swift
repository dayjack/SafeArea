//
//  WeekStore.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import Foundation

class WeekStore: ObservableObject {
    // Combined all Weeks
    @Published var allWeeks: [WeekValue] = []

    // Current chosen date indicator
    @Published var currentDate: Date = Date()

    // Index indicator
    @Published var currentIndex: Int = 0
    @Published var indexToUpdate: Int = 0

    // Array of Weeks
    @Published var currentWeek: [Date] = []
    @Published var nextWeek: [Date] = []
    @Published var previousWeek: [Date] = []

    // Initial append of weeks
    init() {
        fetchCurrentWeek()
        fetchPreviousNextWeek()
        appendAll()
    }
    
//    func koreanTime() -> Date {
//
//        let calendar = Calendar(identifier: .gregorian)
//        let timezone = TimeZone(identifier: "Asia/Seoul")
//
//        var components = calendar.dateComponents(in: timezone!, from: currentDate)
//        components.hour! -= 9 // UTC에서 한국 표준시로 변환
//
//        let convertedDate = calendar.date(from: components)!
//        return convertedDate
//    }

    func appendAll() {
        var newWeek = WeekValue(id: 0, date: currentWeek)
        allWeeks.append(newWeek)

        newWeek = WeekValue(id: 2, date: nextWeek)
        allWeeks.append(newWeek)

        newWeek = WeekValue(id: 1, date: previousWeek)
        allWeeks.append(newWeek)
    }

    func update(index: Int) {
        var value: Int = 0
        if index < currentIndex {
            value = 1
            if indexToUpdate == 2 {
                indexToUpdate = 0
            } else {
                indexToUpdate = indexToUpdate + 1
            }
        } else {
            value = -1
            if indexToUpdate == 0 {
                indexToUpdate = 2
            } else {
                indexToUpdate = indexToUpdate - 1
            }
        }
        currentIndex = index
        addWeek(index: indexToUpdate, value: value)
    }

    func addWeek(index: Int, value: Int) {
        allWeeks[index].date.removeAll()
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")! // Set the timezone to Korean time
        calendar.firstWeekday = 7
        let today = Calendar.current.date(byAdding: .day, value: 7 * value, to: self.currentDate)!
        self.currentDate = today
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!

        (2...8).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                allWeeks[index].date.append(weekday)
            }
        }
    }

    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDate, inSameDayAs: date)
    }

    func dateToString(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }

    func fetchCurrentWeek() {
        let today = currentDate
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")! // Set the timezone to Korean time
        calendar.firstWeekday = 7

        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!

        currentWeek.removeAll()
        (2...8).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                currentWeek.append(weekday)
            }
        }
    }


    func fetchPreviousNextWeek() {
        nextWeek.removeAll()

        let nextWeekToday = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")! // Set the timezone to Korean time
        calendar.firstWeekday = 7

        let startOfWeekNext = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: nextWeekToday))!

        (2...8).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekNext) {
                nextWeek.append(weekday)
            }
        }

        previousWeek.removeAll()
        let previousWeekToday = Calendar.current.date(byAdding: .day, value: -7, to: currentDate)!

        let startOfWeekPrev = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: previousWeekToday))!

        (2...8).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: startOfWeekPrev) {
                previousWeek.append(weekday)
            }
        }
    }
}

struct WeekValue: Identifiable {
    var id: Int
    var date: [Date]
}
