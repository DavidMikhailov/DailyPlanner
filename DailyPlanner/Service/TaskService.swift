//
//  TaskService.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 13.02.2021.
//

import Foundation

protocol TaskServiceProtocol: class {
    func getTask(id: Task.Id, completion: @escaping (Task?) -> Void)
    func observeTasks(date: Date, completion: @escaping ([Task]) -> Void)
    func create(task: Task)
}

class TaskService: TaskServiceProtocol {
    
    private let database: DataStorage
    
    init(database: DataStorage, tasks: [Task] = []) {
        self.database = database
    }
    
    func observeTasks(date: Date, completion: @escaping ([Task]) -> Void) {
        database.observeNewItemsInList(listName: dbListName) { dictArray in
            var tasks = [Task]()
            for (id, value) in dictArray {
                guard let dict = value as? [String: AnyObject], let task = Task(id: id, from: dict) else {
                    continue
                }
                tasks.append(task)
            }
            let filteredTasks = tasks.filter { task in
                Calendar.current.isDate(task.startDate, inSameDayAs: date)
            }
            completion(filteredTasks)
        }
    }
    
    func getTask(id: Task.Id, completion: @escaping (Task?) -> Void) {
        database.read(path: "\(dbListName)/\(id)") {
            guard let dict = $0, let task = Task(id: id, from: dict) else {
                completion(nil)
                return
            }
            completion(task)
        }
    }
    
    func create(task: Task) {
        database.writeToList(listName: dbListName, dict: task.toDict)
    }
    
    private let dbListName = "tasks"
}

extension Task {
    var toDict: [String: String] {
        return [
            "startDate": String(Int(self.startDate.timeIntervalSince1970)),
            "finishDate": String(Int(self.finishDate.timeIntervalSince1970)),
            "name":  self.name,
            "description": self.description
        ]
    }
    
    init?(id: Task.Id, from dict: [String: Any]) {
        guard let startDateStr = dict["startDate"] as? String,
              let startDate = Int(startDateStr).map(TimeInterval.init).map(Date.init(timeIntervalSince1970:)),
              let finishDateStr = dict["finishDate"] as? String,
              let finishDate = Int(finishDateStr).map(TimeInterval.init).map(Date.init(timeIntervalSince1970:)),
              let name = dict["name"] as? String,
              let description = dict["description"] as? String else {
            return nil
        }
        self = Task(
            id: id,
            startDate: startDate,
            finishDate: finishDate,
            name: name,
            description: description
        )
    }
}
