//
//  DetailTaskViewController.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 12.02.2021.
//

import UIKit

class DetailTaskViewController: UIViewController {
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDateAndTimeLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    var destArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameLabel.text = destArray[0]
        taskDescriptionLabel.text = destArray[1]
        taskDateAndTimeLabel.text = destArray[2]
        
    }
}
