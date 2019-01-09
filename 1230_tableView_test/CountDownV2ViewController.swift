//
//  CountDownV2ViewController.swift
//  1230_tableView_test
//
//  Created by PigFactory on 08/01/2019.
//  Copyright © 2019 PigFactory. All rights reserved.
//

import UIKit

class CountDownV2ViewController: UIViewController {
    
    var sets: [String] = []
    var counts: [String] = []
    
    var timer = Timer()
 
    var set:UInt = 0
    var count:UInt = 0
    var setCount: UInt = 0
    
    @IBOutlet weak var setNumber: UILabel!
    @IBOutlet weak var countNumber: UILabel!
    

    @IBOutlet weak var viewLayer: UIView!
    @IBOutlet var butttonLayer: [UIButton]!
    @IBOutlet var topView: [UIView]!
    @IBOutlet var topLableView: [UIView]!
    
    @IBOutlet weak var playButtonView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)

        
        for i in 0...999 {
            sets.append(String(i))
            counts.append(String(i))
        }
        
        viewLayer.layer.cornerRadius = 15
        viewLayer.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        for i in butttonLayer {
            i.layer.cornerRadius = 15
            i.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }
        
        for i in topView {
            i.layer.cornerRadius = 15
            i.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            i.layer.masksToBounds = true
        }
        
        for i in topLableView {
            i.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        }

    }
    
    @IBAction func alert(_ sender: UIButton) {
        timer.invalidate()
        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)

        
        
        let alert = UIAlertController(title: "Set & Count", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame1 = UIPickerView(frame: CGRect(x: 10, y: 50, width: 70, height: 160))
        let pickerFrame2 = UIPickerView(frame: CGRect(x: 80, y: 50, width: 180, height: 160))
        
        let set = UILabel(frame: CGRect(x: 75, y: 120, width: 50, height: 20))
        let count = UILabel(frame: CGRect(x: 200, y: 120, width: 50, height: 20))
        
        
        alert.view.addSubview(pickerFrame1)
        alert.view.addSubview(pickerFrame2)
        
        alert.view.addSubview(set)
        alert.view.addSubview(count)

        set.text = "Set"
        count.text = "Count"
        
        pickerFrame1.dataSource = self
        pickerFrame1.delegate = self
        
        pickerFrame2.dataSource = self
        pickerFrame2.delegate = self
        
        pickerFrame1.tag = 0
        pickerFrame2.tag = 1
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.ok))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: self.cancel))
        present(alert, animated: true, completion: nil )
    }
    
    func ok(alert: UIAlertAction) {
        if count > 0 && set > 0 {
            setCount = count
            playButtonView.isEnabled = true
            playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else if count > 0 && set == 0 {
            playButtonView.isEnabled = true
            playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        setNumber.text = String(set)
        countNumber.text = String(count)
    }
    
    func cancel(alert: UIAlertAction) {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateStopwatch),
            userInfo: nil,
            repeats: true
        )
        
        if count > 0 {
            playButtonView.isEnabled = true
            playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func playButton(_ sender: Any) {
        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateStopwatch),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func updateStopwatch() {
        if count >= 1 {
            count -= 1
            countNumber.text = String(count)
            if count == 0 && set > 0 {
                set -= 1
                count = setCount
                countNumber.text = String(count)
                setNumber.text = String(set)
            }
        } else {
            timer.invalidate()
        }
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        if count != 0 {
        playButtonView.isEnabled = true
        playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            playButtonView.isEnabled = false
            playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)

        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        
        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        
        count = 0
        set = 0
        
        countNumber.text = "0"
        setNumber.text = "0"
    }
    
    @IBAction func plusOneButton(_ sender: Any) {
        count += 1
        calcul()
    }
    
    @IBAction func plusTenButton(_ sender: Any) {
        count += 10
        calcul()
    }
    
    @IBAction func plusFiftyButton(_ sender: Any) {
        count += 50
        calcul()
    }
    
    @IBAction func plusHundredButton(_ sender: Any) {
        count += 100
        calcul()
    }
    
    @IBAction func minusOneButton(_ sender: Any) {
        if count > 0 {
            count -= 1
            calcul()
        }
    }
    
    
    @IBAction func minusTenButton(_ sender: Any) {
        if count > 9 {
            count -= 10
            calcul()
        }
    }
    
    @IBAction func minusFiftyButton(_ sender: Any) {
        if count > 49 {
            count -= 50
            calcul()
        }
    }
    
    @IBAction func minusHundredButton(_ sender: Any) {
        if count > 99 {
            count -= 100
            calcul()
        }
    }
    
    func calcul() {
        timer.invalidate()
        countNumber.text = String(count)
        
        if count != 0 {
            playButtonView.isEnabled = true
            playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        } else {
            playButtonView.isEnabled = false
            playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        }
    }
    
    
    

}

extension CountDownV2ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return sets.count
        case 1:
            return counts.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return sets[row]
        case 1:
            return counts[row]
        default:
            return "kkk"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            set = UInt(sets[row])!
        case 1:
            count = UInt(counts[row])!
        default:
            print("nothing")
        }
        
    }
    
    
    
    
}
