//
//  DetailTaskViewController.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 12.02.2021.
//

import UIKit

protocol DetailTaskUI: class {
    func dataChanged()
}

class DetailTaskViewController: UIViewController, DetailTaskUI {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDateAndTimeLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    var presenter: DetailTaskPresenterProtocol!
    
    func dataChanged() {
        guard let taskViewModel = presenter.taskViewModel else {
            return
        }
        taskNameLabel.text = taskViewModel.name
        taskDescriptionLabel.text = taskViewModel.description
        taskDateAndTimeLabel.text = taskViewModel.time
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.load(ui: self)
    }
}
