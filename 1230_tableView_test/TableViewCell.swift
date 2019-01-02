//
//  TableViewCell.swift
//  1230_tableView_test
//
//  Created by PigFactory on 30/12/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var items = ["10", "20", "30", "40", "50"]
    var choices = ["1","2","3","4","5"]
    
    var pickerView = UIPickerView()
    var typeValue = String()
    
    var setValue = "1"
    var countValue = "10"
    
    var set = 0
    var count = 0

    var viewController: ViewController?
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var blackView2: UIView!
    
    var nameTextField: UITextField?
    
    @IBOutlet weak var setText: UIButton!
    @IBOutlet weak var countText: UIButton!
    
    @IBOutlet weak var number: UILabel!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    var timer = Timer()
    var counter = 0.0
    var isRunning = false

    override func awakeFromNib() {
//        view.layer.cornerRadius = 10
//        view2.layer.cornerRadius = 10
        viewRightRoundCorners(item: view2, cornerRadius: 10)
        viewLeftRoundCorners(item: view, cornerRadius: 10)
        buttonView.layer.cornerRadius = 10
        buttonView.clipsToBounds = true

        
        blackView.layer.cornerRadius = 10
        blackView.clipsToBounds = true
        
        blackView2.layer.cornerRadius = 10
        blackView2.clipsToBounds = true
        
        number.text = "\(counter)"
        startButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    func viewRightRoundCorners(item: UIView, cornerRadius: Double) {
        item.layer.cornerRadius = CGFloat(cornerRadius)
        item.clipsToBounds = true
        item.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func viewLeftRoundCorners(item: UIView, cornerRadius: Double) {
        item.layer.cornerRadius = CGFloat(cornerRadius)
        item.clipsToBounds = true
        item.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        viewController?.Delete(cell: self)
    }
    
    @IBAction func alert(_ sender: UIButton) {
        let alert = UIAlertController(title: "운동 세트 설정", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame1 = UIPickerView(frame: CGRect(x: 30, y: 70, width: 100, height: 160))
        let pickerFrame2 = UIPickerView(frame: CGRect(x: 140, y: 70, width: 100, height: 160))
        let set = UILabel(frame: CGRect(x: 70, y: 60, width: 100, height: 20))
        let count = UILabel(frame: CGRect(x: 165, y: 60, width: 100, height: 20))

        alert.view.addSubview(pickerFrame1)
        alert.view.addSubview(pickerFrame2)
        alert.view.addSubview(set)
        alert.view.addSubview(count)
        set.text = "SET"
        count.text = "COUNT"
        
        
        pickerFrame1.dataSource = self
        pickerFrame1.delegate = self
        
        pickerFrame2.dataSource = self
        pickerFrame2.delegate = self
        
        pickerFrame1.tag = 0
        pickerFrame2.tag = 1
        
        alert.addTextField(configurationHandler: nameTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.ok))
        viewController?.present(alert, animated: true, completion: nil )
    }
    
    func nameTextField(textField: UITextField) {
        nameTextField = textField
        nameTextField?.text = "운동종류"
//        nameTextField?.placeholder = "운동 종류"
    }
    
    func ok(alert: UIAlertAction) {
        labelView.text = nameTextField?.text
        setText.setTitle(setValue, for: UIControl.State.normal)
        countText.setTitle(countValue, for: UIControl.State.normal)
        
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        startButton.isEnabled = false
        pauseButton.isEnabled = true
        isRunning = true
    }
    
    @objc func UpdateTimer() {
        counter += 0.1
        number.text = String(format: "%.1f", counter)
    }
    
    @IBAction func ResetButton(_ sender: UIButton) {
        timer.invalidate()
        counter = 0
        number.text = "\(counter)"
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        isRunning = false
    }
    
    @IBAction func PauseButton(_ sender: Any) {
        timer.invalidate()
        startButton.isEnabled = true
        pauseButton.isEnabled = false
        isRunning = false
    }
    
    
    @IBAction func setButton(_ sender: UIButton) {
        set = Int(setValue)!
        print(set)
        if set > 0 {
            set -= 1
        }
        setText.setTitle(String(set), for: UIControl.State.normal)
        setValue = String(set)
    }
    
    @IBAction func countButton(_ sender: UIButton) {
        count = Int(countValue)!
        print(count)
        if count > 0 {
            count -= 1
        }
        countText.setTitle(String(count), for: UIControl.State.normal)
        countValue = String(count)
        print(count)
    }
    
}

extension TableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return choices[row]
        case 1:
            return items[row]
        default:
            return "kkk"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            setValue = choices[row]
        case 1:
            countValue = items[row]
        default:
            print("nothing")
        }
    }
    
}

