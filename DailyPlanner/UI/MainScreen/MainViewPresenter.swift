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
    
    func load(ui: MainViewProtocol)
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
    struct TapContext {
        let id: Task.Id
    }
    
    let tapContext: TapContext
    let time: String
    let taskName: String
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    init(service: TaskServiceProtocol) {
        self.service = service
    }
    
    private weak var ui: MainViewProtocol!
    private let service: TaskServiceProtocol
    
    var items: [TasksCellState] = []
    
    func load(ui: MainViewProtocol) {
        self.ui = ui
        didSelect(date: Date())
    }
    
    func didSelect(date: Date) {
        service.observeTasks(date: date, completion: { [weak self] tasks in
            guard let self = self else { return }
            
            var newItems: [TasksCellState] = []
            for hour in 0...23 {
                var resultTask: TaskCellState?
                tasks.forEach { task in
                    let startHour = Calendar.current.component(.hour, from: task.startDate)
                    let finishHour = Calendar.current.component(.hour, from: task.finishDate)
                    if hour >= startHour && hour < finishHour {
                        resultTask = TaskCellState(
                            tapContext: TaskCellState.TapContext(id: task.id),
                            time: "\(startHour):00 - \(finishHour):00",
                            taskName: task.name
                        )
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
