//
//  Time.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 11.02.2021.
//

import Foundation
//import FirebaseDatabase

struct Task {
    
    let day_id: Int
    let taskDate_start: Int
    let taskDate_finish: Int
    let taskName: String
    let taskDescription: String
//    let ref: DatabaseReference?
    
    init(day_id: Int, taskDate_start: Int, taskDate_finish: Int, taskName: String, taskDescription: String) {
        self.day_id = day_id
        self.taskDate_start = taskDate_start
        self.taskDate_finish = taskDate_finish
        self.taskName = taskName
        self.taskDescription = taskDescription
//        self.ref = nil
    }
//
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String:AnyObject]
//        day_id = snapshotValue["day_id"] as! Int
//        taskDate_start = snapshotValue["taskDate_start"] as! Int
//        taskDate_finish = snapshotValue["taskDate_finish"] as! Int
//        taskName = snapshotValue["taskName"] as! String
//        taskDescription = snapshotValue["taskDescription"] as! String
//        ref = snapshot.ref
//    }
}
