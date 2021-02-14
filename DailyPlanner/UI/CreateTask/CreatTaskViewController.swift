//
//  CreatTaskViewController.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 13.02.2021.
//

import UIKit

class CreatTaskViewController: UIViewController {

    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDateStart: UITextField!
    @IBOutlet weak var taskDateFinish: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    
    var presenter: CreateTaskPresenterProtocol = CreateTaskPresenter(taskService: taskService)
    
    let datePicker = UIDatePicker()
    //MARK: - Toolbars for dateStart and dateFinish
    let toolbar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskDateStart.inputView = datePicker
        taskDateFinish.inputView = datePicker
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = .dateAndTime
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        toolbar.sizeToFit()
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        taskDateStart.inputAccessoryView = toolbar
        taskDateFinish.inputAccessoryView = toolbar
                
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func doneAction () {
        view.endEditing(true)
    }
    
    func getDateFromPicker() {
        taskDateStart.text = dateFormatter.string(from: datePicker.date)
    }
    
    func getDateFromPicker1() {
        taskDateFinish.text = dateFormatter.string(from: datePicker.date)
    }
    
    // MARK:- working with selection of the day

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, HH:mm "
        return formatter
    }()
    
    @objc func dateChanged(sender: UIDatePicker) {
        if taskDateStart.isFirstResponder {
            presenter.startDate = sender.date
            getDateFromPicker()
        } else if taskDateFinish.isFirstResponder {
            presenter.endDate = sender.date
            getDateFromPicker1()
        }
    }
        
    @IBAction func saveAction(_ sender: Any) {
        presenter.name = taskName.text ?? ""
        presenter.description = taskDescription.text ?? ""
        let isSaved = presenter.save()
        if isSaved {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - Extension

extension CreatTaskViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreatTaskViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

