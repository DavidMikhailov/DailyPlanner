//
//  ViewController.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 11.02.2021.
//

import UIKit
import FSCalendar
//import FirebaseDatabase

protocol MainViewProtocol: class {
    func dataChanged()
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FSCalendarDelegate, MainViewProtocol {
        
    var presenter: MainViewPresenterProtocol = MainViewPresenter()
    
    var incomeTasks = [Task]()
    var timeArray = [Date]()
    var dayTasksArray = [Task]()
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.ui = self
        tableView.dataSource = self
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
        //        let caseLeftHour = timeArray[indexPath.row].time.hour
        //        let caseRightHour = timeArray[indexPath.row].time.hour + 1
        //        let (name,description) = checkTaskIsInTheRange(caseLeftHour: caseLeftHour, caseRightHour: caseRightHour)
        //        let caseDescriptionArray = [name,description, String(timeArray[indexPath.row].time.hour) + ":" + String(timeArray[indexPath.row].time.minute) + "0 - " + String(timeArray[indexPath.row].time.hour + 1) + ":" + String(timeArray[indexPath.row].time.minute) + "0"]
        //
        //        performSegue(withIdentifier: "segueDetailTask", sender: caseDescriptionArray)
    }
    
    
    // MARK: - MainViewProtocol
    func dataChanged() {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailTaskViewController {
            vc.destArray = sender as! [String]
        }
    }
    
    //
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        presenter.didSelect(date: date)
//                dayTasksArray = [Task]()
//                let formatter = DateFormatter()
//                formatter.dateFormat = "dd"
//                let dayString = formatter.string(from: date)
//                let dayNumber = Int(dayString)
//                dayTasksArray = getTasksByDay(dayNumber!)
    }
    
    //    func getTasksByDay(_ day_id: Int) -> [Task] {
    //        let filePath = Bundle.main.path(forResource: "Data", ofType: "json")!
    //        var dayCasesArray = [Task]()
    //        do {
    //            let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    //            incomeTasks = try JSONDecoder().decode([Task].self, from: data)
    //
    //        }
    //        catch{
    //            print(error)
    //        }
    //        for item in incomeTasks{
    //            if item.day_id == day_id {
    //                dayCasesArray.append(item)
    //            }
    //        }
    //        return dayCasesArray
    //    }
    
//
//    func checkTaskIsInTheRange(caseLeftHour: Int, caseRightHour: Int) -> (String, String) {
//        var dateStart = 0
//        var dateFinish = 0
//        print(dayTasksArray)
//        for item in dayTasksArray {
//            if String(item.taskDate_start).count > 2 {
//                //                dateStart = Date(timeIntervalSince1970: Double(Int(item.taskDate_start))).time.hour
//                //                dateFinish = Date(timeIntervalSince1970: Double(Int(item.taskDate_finish))).time.hour
//                print(caseLeftHour,dateStart, caseRightHour, dateFinish)
//            } else {
//                dateStart = item.taskDate_start
//                dateFinish = item.taskDate_finish
//                print(caseLeftHour, dateStart,caseRightHour, dateFinish)
//            }
//            if dateStart >= caseLeftHour && dateFinish < caseRightHour  {
//                return (item.taskName, item.taskDescription)
//            }
//        }
//        return ("","")
//    }
}
