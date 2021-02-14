//
//  Time.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 11.02.2021.
//

import Foundation

struct Task {
    typealias Id = String
    
    let id: Id
    let startDate: Date
    let finishDate: Date
    let name: String
    let description: String
}
