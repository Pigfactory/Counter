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
    var choices = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var weight = ["5","10","15","20","25","30","35","40","45","50","55","60","65","70","75"]

    var pickerView = UIPickerView()
    var typeValue = String()
    
    var setValue = "1"
    var countValue = "10"
    var weightValue = "5"
    
    var set = 0
    var count = 0

    var viewController: ViewController?
    
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var view: UIView!    //왼쪽 배경
    @IBOutlet weak var view2: UIView!   //오른쪽 배경
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var blackView2: UIView!
    @IBOutlet weak var blackView3: UIView!
    
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var whiteView2: UIView!
    @IBOutlet weak var whiteView3: UIView!
    
    var nameTextField: UITextField?
    
    @IBOutlet weak var setText: UIButton!
    @IBOutlet weak var countText: UIButton!
    @IBOutlet weak var weightText: UIButton!
    
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
        viewRightRoundCorners(item: view2, cornerRadius: 15)
        viewLeftRoundCorners(item: view, cornerRadius: 15)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view2.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        buttonView.layer.cornerRadius = 15
        buttonView.clipsToBounds = true
        
        //세트
        blackView.layer.cornerRadius = 15
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        whiteView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        blackView.clipsToBounds = true
        
        //회수
        blackView2.layer.cornerRadius = 15
        blackView2.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        whiteView2.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        blackView2.clipsToBounds = true
        
        //중량
        blackView3.layer.cornerRadius = 15
        blackView3.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        whiteView3.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        blackView3.clipsToBounds = true
        
        buttonView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
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
        
        let pickerFrame1 = UIPickerView(frame: CGRect(x: 20, y: 70, width: 70, height: 160))
        let pickerFrame2 = UIPickerView(frame: CGRect(x: 100, y: 70, width: 70, height: 160))
        let pickerFrame3 = UIPickerView(frame: CGRect(x: 180, y: 70, width: 70, height: 160))

        let set = UILabel(frame: CGRect(x: 40, y: 60, width: 50, height: 20))
        let count = UILabel(frame: CGRect(x: 120, y: 60, width: 50, height: 20))
        let weight = UILabel(frame: CGRect(x: 200, y: 60, width: 50, height: 20))

        alert.view.addSubview(pickerFrame1)
        alert.view.addSubview(pickerFrame2)
        alert.view.addSubview(pickerFrame3)
        
        alert.view.addSubview(set)
        alert.view.addSubview(count)
        alert.view.addSubview(weight)
        set.text = "세트"
        count.text = "개수"
        weight.text = "중량"
        
        
        pickerFrame1.dataSource = self
        pickerFrame1.delegate = self
        
        pickerFrame2.dataSource = self
        pickerFrame2.delegate = self
        
        pickerFrame3.dataSource = self
        pickerFrame3.delegate = self
        
        pickerFrame1.tag = 0
        pickerFrame2.tag = 1
        pickerFrame3.tag = 2
        
        alert.addTextField(configurationHandler: nameTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: self.cancel))
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
        weightText.setTitle(weightValue, for: UIControl.State.normal)
    }
    
    func cancel(alert: UIAlertAction) {
        setValue = "1"
        countValue = "10"
        weightValue = "5"
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
        switch pickerView.tag {
        case 0:
            return choices.count
        case 1:
            return items.count
        case 2:
            return weight.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return choices[row]
        case 1:
            return items[row]
        case 2:
            return weight[row]
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
        case 2:
            weightValue = weight[row]
        default:
            print("nothing")
        }
    }
}

