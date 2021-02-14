//
//  CreateTaskPresenter.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 13.02.2021.
//

import UIKit

protocol CreateTaskPresenterProtocol: class {
    var name: String { get set }
    var description: String { get set  }
    var startDate: Date? { get set  }
    var endDate: Date? { get set }
    
    func save() -> Bool
}

class CreateTaskPresenter: CreateTaskPresenterProtocol {
    
    init(taskService: TaskServiceProtocol) {
        self.taskService = taskService
    }
    
    let taskService: TaskServiceProtocol
    
    var name: String = ""
    var description: String = ""
    var startDate: Date?
    var endDate: Date?
    
    func save() -> Bool {
        guard let startDate = startDate,
              let endDate = endDate,
              !name.isEmpty,
              !description.isEmpty
              else {
            return false
        }
        let task = Task(
            id: UUID().uuidString,
            startDate: startDate,
            finishDate: endDate,
            name: name,
            description: description
        )
        taskService.create(task: task)
        return true
    }
}
