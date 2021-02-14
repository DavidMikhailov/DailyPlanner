//
//  ViewController.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 11.02.2021.
//

import UIKit
import FSCalendar

protocol MainViewProtocol: class {
    func dataChanged()
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate, MainViewProtocol {
        
    var presenter: MainViewPresenterProtocol = MainViewPresenter(service: taskService)
    
    var incomeTasks = [Task]()
    var timeArray = [Date]()
    var dayTasksArray = [Task]()
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load(ui: self)
        tableView.dataSource = self
        tableView.delegate = self
        calendar.delegate = self
    }
    
    //MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = presenter.items[indexPath.row]
        switch item {
        case .task(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
            cell.textLabel?.text = "\(data.time): \(data.taskName)"
            cell.backgroundColor = .cyan
            return cell
        case .time(let data):
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath)
            cell.textLabel?.text = "\(data.time)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = presenter.items[indexPath.row]
        switch item {
        case .task(let data):
            let tadkId = data.tapContext.id
            let detailsPresenter = DetailTaskPresenter(taskId: tadkId, tasksService: taskService)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailsVc = storyboard.instantiateViewController(withIdentifier: String(describing: DetailTaskViewController.self)) as! DetailTaskViewController
            detailsVc.presenter = detailsPresenter
            self.navigationController?.pushViewController(detailsVc, animated: true)
        default:
            return
        }
    }
    
    // MARK: - MainViewProtocol
    func dataChanged() {
        tableView.reloadData()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presenter.didSelect(date: date)
    }
}
