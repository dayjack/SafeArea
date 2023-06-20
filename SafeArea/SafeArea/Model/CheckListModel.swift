//
//  CheckListModel.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import Foundation

class CheckListModel: ObservableObject {
    @Published var id: Int
    @Published var bools: String
    @Published var date: String
    
    init(id: Int, bools: String, date: String) {
        self.id = id
        self.bools = bools
        self.date = date
    }
}
