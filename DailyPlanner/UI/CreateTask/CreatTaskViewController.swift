//
//  CreatTaskViewController.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 11.02.2021.
//

import UIKit
import FSCalendar
//import FirebaseDatabase

class CreatTaskViewController: UIViewController {
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDateStart: UITextField!
    @IBOutlet weak var taskDateFinish: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    
    //
    //    var dayNumber = 0
    //    var hours:Int = 0
    //    var currentDate = Date()
    //    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDateStart.inputView = datePicker
        taskDateFinish.inputView = datePicker
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = .dateAndTime
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
//        datePicker.
        
        toolbar.sizeToFit()
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        taskDateStart.inputAccessoryView = toolbar
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {return}
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.height + kbFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.height)
        
    }
    
    @objc func doneAction () {
        
    }
    
    
    //MARK:- working with selection of the day
    
    func getDateFromPicker() {
        
    }
    
    
    //    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "dd"
    //        let dayString = formatter.string(from: date)
    //        print("Selected", dayString)
    //        dayNumber = Int(dayString)!
    @IBAction func createButtonPressed(_ sender: UIBarButtonItem) {
        
        
        //        let task = Task(day_id: dayNumber, taskDate_start: <#T##Int#>, taskDate_finish: <#T##Int#>, taskName: nameTextField.text, taskDescription: descriptionTextFeild.text)
        //        let ref = self.ref.child(task.taskName.lowerCased())
        
    }

}





