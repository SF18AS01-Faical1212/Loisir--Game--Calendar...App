//
//  DetailViewController.swift
//  DynamicTable
//
//  Created by Faical Sawadogo1212 on 03/01/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var date: UITextField!
    
    var datePicker: UIDatePicker?
    
    var selectedRow: Int?
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DetailViewController.dateChanged(datePicker:)), for: .valueChanged)
        view.endEditing(true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.viewTapper(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        date.inputView = datePicker
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        date.text = formatter.string(from: datePicker.date)
        
    }
    
    @objc func viewTapper(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }

    override func viewWillAppear(_ animated: Bool) {
        // Set name
        name.text = item?.name
        
        // Set number
        number.text = item?.number
        
        // Set date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        date.text = formatter.string(from: item?.date as! Date)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Save the name
        item?.name = name.text!
        
        // Save the number
        item?.number = number.text!
        
        // Save date
        item?.date = datePicker?.date as! NSDate
    }

}
