//
//  MainViewPresenter.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 13.02.2021.
//

import UIKit

protocol MainViewPresenterProtocol: class {
    var items: [TasksCellState] { get }
    func didSelect(date: Date)
    var ui: MainViewProtocol! { get set }
}

enum TasksCellState {
    case time(HourCellState)
    case task(TaskCellState)
}

struct HourCellState {
    let hour: Int
    
    var time: String {
        return "\(hour):00"
    }
}

struct TaskCellState {
    let id: Int
    let time: String
    let taskName: String
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    weak var ui: MainViewProtocol!
    var service: TaskServiceProtocol = TaskService()
    
    var items: [TasksCellState] = []
    
    func didSelect(date: Date) {
        service.getTasks(date: date, completion: { [weak self] tasks in
            guard let self = self else { return }
            
            var newItems: [TasksCellState] = []
            for hour in 0...23 {
                var resultTask: TaskCellState?
                tasks.forEach { task in
                    let startHour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(task.taskDate_start)))
                    let finishHour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(task.taskDate_finish)))
                    if hour >= startHour && hour <= finishHour {
                        resultTask = TaskCellState(id: task.day_id, time: "\(startHour):00-\(finishHour):00", taskName: task.taskName)
                        return
                    }
                }
                if let task = resultTask {
                    newItems.append(.task(task))
                } else {
                    newItems.append(.time(HourCellState(hour: hour)))
                }
            }
            DispatchQueue.main.async {
                self.items = newItems
                self.ui.dataChanged()
            }
        })
    }

    //
    private lazy var hoursArray: [HourCellState] = {
        var array: [HourCellState] = []
        for i in 0...23 {
            array.append(HourCellState(hour: i))
        }
        return array
    }()
}
