//
//  DetailTaskPresenter.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 14.02.2021.
//

import UIKit

struct TaskViewModel {
    let name: String
    let description: String
    let time: String
}

protocol DetailTaskPresenterProtocol {
    var taskViewModel: TaskViewModel? { get }
    func load(ui: DetailTaskUI)
}

class DetailTaskPresenter: DetailTaskPresenterProtocol {
    private let taskId: Task.Id
    private let tasksService: TaskServiceProtocol
    private weak var ui: DetailTaskUI!
    
    init(taskId: Task.Id, tasksService: TaskServiceProtocol) {
        self.taskId = taskId
        self.tasksService = tasksService
    }
    
    func load(ui: DetailTaskUI) {
        self.ui = ui
        tasksService.getTask(id: taskId) { [weak self] task in
            guard let self = self, let task = task else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                self.taskViewModel = TaskViewModel(
                    name: task.name,
                    description: task.description,
                    time: self.formateDates(start: task.startDate, finish: task.finishDate)
                )
                self.ui.dataChanged()
            }
        }
    }
    
    var taskViewModel: TaskViewModel?
    
    // MARK: - Private
        
    private func formateDates(start: Date, finish: Date) -> String {
        let day = dayFormatter.string(from: start)
        let startHours = hoursFormatter.string(from: start)
        let finishHours = hoursFormatter.string(from: finish)
        return day + " " + startHours + " — " + finishHours
    }
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter
    }()
    
    private let hoursFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
