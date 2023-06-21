//
//  DBHelper.swift
//  SafeArea
//
//  Created by ChoiYujin on 2023/06/20.
//

import Foundation
import SQLite3
import SwiftUI

class DBHelper {
    
    static let shared = DBHelper()
    let databaseName = "mydb.sqlite"
    var db : OpaquePointer?
    
    private init() {}
    deinit { sqlite3_close(db) }
    
    func createDB() -> OpaquePointer? {
        var db: OpaquePointer? = nil
        
        do {
            // MARK: - url 수정
            let dbPath: String = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(databaseName).path
            
            if sqlite3_open(dbPath, &db) == SQLITE_OK {
                print("Successfullt create DB.path: \(dbPath)")
                self.db = db
                return db
            }
        } catch {
            print("Error while creating Database - \(error.localizedDescription)")
        }
        return nil
    }
    
    func onSQLErrorPrintErrorMessage(_ db: OpaquePointer?) {
        let errorMessage = String(cString: sqlite3_errmsg(db))
        print("Error preparing update: \(errorMessage)")
        return
    }
    
    func dropTable(tableName: String) {
        
        let queryString = "DROP TABLE \(tableName)"
        var statement: OpaquePointer?
        
        if sqlite3_prepare(db, queryString, -1, &statement, nil) != SQLITE_OK {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        // 쿼리 실행.
        if sqlite3_step(statement) != SQLITE_DONE {
            onSQLErrorPrintErrorMessage(db)
            return
        }
        
        print("drop table has been successfully done")
        
    }
}


// MARK: - CheckList
extension DBHelper {
    
    func createCheckListTable() {
        let query = """
          CREATE TABLE IF NOT EXISTS CheckList (
            `id` INTEGER PRIMARY KEY AUTOINCREMENT,
            `bools` CHAR(255) NOT NULL,
            `date` CHAR(255) NOT NULL
          ) ;
          """
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            // step은 쿼리를 실행하는 단계
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Creating Dream Log table has been succesfully done. db : \(String(describing: self.db))")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(self.db))
                print("\nsqlite3_prepare failure while createing table: \(errorMessage)")
            }
            sqlite3_finalize(statement)
        }
    }
    
    func insertCheckListData(bools: String, date: String) {
        // id 는 Auto increment 속성을 갖고 있기에 값을 대입해 줄 필요는 없지만 쿼리문에는 있어야함
        let insertQuery = """
            INSERT INTO CheckList (`id`, `bools`, `date`)
            SELECT ?, ?, ?
            WHERE NOT EXISTS (
                SELECT 1 FROM CheckList WHERE `date` = ?
            );
            """
        
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, insertQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 2, bools, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 3, date, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 4, date, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
        }
        else {
            print("sqlite binding failure")
        }
        // step은 쿼리를 실행하는 단계
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    func readCheckListData() -> [CheckListModel] {
//        let query: String = "SELECT * FROM CheckList ORDER BY id DESC;"
        let query: String = "SELECT * FROM CheckList;"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: [CheckListModel] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let bools = String(cString: sqlite3_column_text(statement, 1))
            let date = String(cString: sqlite3_column_text(statement, 2))
            
            result.append(.init(id: Int(id), bools: bools, date: date))
        }
        sqlite3_finalize(statement)
        print("result - readCheckListData: \(result)")
        return result
    }
    
    func readCheckListData(date: String) -> [CheckListModel] {
        let query: String = "SELECT * FROM CheckList where date = '\(date)';"
        var statement: OpaquePointer? = nil
        
        // 아래는 [MyModel]? 이 되면 값이 안 들어간다.
        var result: [CheckListModel] = []
        
        if sqlite3_prepare(self.db, query, -1, &statement, nil) != SQLITE_OK {
            let errorMessage = String(cString: sqlite3_errmsg(db)!)
            print("error while prepare: \(errorMessage)")
            return result
        }
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let bools = String(cString: sqlite3_column_text(statement, 1))
            let date = String(cString: sqlite3_column_text(statement, 2))
            
            result.append(.init(id: Int(id), bools: bools, date: date))
        }
        sqlite3_finalize(statement)
        print("result - readCheckListData: \(result)")
        return result
    }
    
    func updateCheckListData(bools: String, date: String) {
        
        var updateQuery = ""
        print(readCheckListData(date: date))
        if readCheckListData(date: date).isEmpty {
            insertCheckListData(bools: bools, date: date)
            print("insertCheckListData")
            return
        } else {
            updateQuery = """
                UPDATE CheckList SET `bools` = ? WHERE date = ?;
                """
            print("updateQuery")
        }
        // UPDATE [테이블] SET [열] = '변경할값' WHERE [조건]
        
        var statement: OpaquePointer? = nil
        // prepare는 쿼리를 실행할 준비를 하는 단계
        if sqlite3_prepare_v2(self.db, updateQuery, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, bools, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
            sqlite3_bind_text(statement, 2, date, -1, unsafeBitCast(-1, to: sqlite3_destructor_type.self))
        }
        else {
            print("sqlite binding failure")
        }
        // step은 쿼리를 실행하는 단계
        if sqlite3_step(statement) == SQLITE_DONE {
            print("sqlite insertion success")
        }
        else {
            print("sqlite step failure")
        }
    }
    
    
}
