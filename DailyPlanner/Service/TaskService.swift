//
//  TaskService.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 13.02.2021.
//

import Foundation

protocol TaskServiceProtocol: class {
    func getTasks(date: Date, completion: @escaping ([Task]) -> Void)
}

class TaskService: TaskServiceProtocol {
//
//    let date = Date()
    
    var tasks: [Task] = [
        Task(
            day_id: 1,
            taskDate_start: Int(Calendar.current.date(bySettingHour: 9, minute: 00, second: 0, of: Date())!.timeIntervalSince1970),
            taskDate_finish: Int(Calendar.current.date(bySettingHour: 10, minute: 00, second: 0, of: Date())!.timeIntervalSince1970),
            taskName: "Зарядка",
            taskDescription: "Описание упражнений"
        ),
        Task(
            day_id: 2,
            taskDate_start: Int(Calendar.current.date(bySettingHour: 13, minute: 00, second: 0, of: Date())!.timeIntervalSince1970),
            taskDate_finish: Int(Calendar.current.date(bySettingHour: 16, minute: 00, second: 0, of: Date())!.timeIntervalSince1970),
            taskName: "Дела",
            taskDescription: "Дела описание"
        )
//        Task(day_id: 3, taskDate_start: <#T##Int#>, taskDate_finish: <#T##Int#>, taskName: "Работа", taskDescription: "Проверить список дел")
    ]
    
    func getTasks(date: Date, completion: @escaping ([Task]) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            completion(self.tasks)
        })
            
        
        
//        let date = Date()
//        let start1 = Calendar.current.date(bySettingHour: 9, minute: 00, second: 0, of: date)!
//        let start2 =
//        let start2 = Calendar.current.date(bySettingHour: 9, minute: 30, second: 0, of: date)!
//        Calendar.current.da
    }
}
