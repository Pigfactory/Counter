
//
//  CountDownViewController.swift
//  1230_tableView_test
//
//  Created by PigFactory on 06/01/2019.
//  Copyright © 2019 PigFactory. All rights reserved.
//

import UIKit

class CountDownViewController: UIViewController {
    
    var sets: [String] = []
    var hours: [String] = []
    var minutes: [String] = []
    var bars: [UIView] = []
    var setBars: [UIView] = []

    var timer = Timer()
    var h:UInt = 0
    var m:UInt = 0
    var s:UInt = 0
    var set:Int = 0
    
    var stopwatchString = ""


    @IBOutlet weak var barBackgroundView: UIView!
    @IBOutlet weak var bar01: UIView!
    @IBOutlet weak var bar02: UIView!
    @IBOutlet weak var bar03: UIView!
    @IBOutlet weak var bar04: UIView!
    @IBOutlet weak var bar05: UIView!
    @IBOutlet weak var bar06: UIView!
    @IBOutlet weak var bar07: UIView!
    @IBOutlet weak var bar08: UIView!
    @IBOutlet weak var bar09: UIView!
    @IBOutlet weak var bar10: UIView!
    
    @IBOutlet weak var numberBackgroundView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var playButtonView: UIButton!
    @IBOutlet weak var pauseButtonView: UIButton!
    @IBOutlet weak var resetButtonView: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...10 {
            sets.append(String(i))
        }
        
        for i in 0...99 {
            hours.append(String(i))
        }
        
        for i in 0...59 {
            minutes.append(String(i))
        }
        
        bars = [bar01, bar02, bar03, bar04, bar05, bar06, bar07, bar08, bar09, bar10]
//        bar01.layer.borderWidth = 2
//        bar01.layer.borderColor = UIColor.black.cgColor
        
        for i in bars {
            i.backgroundColor = UIColor.red.withAlphaComponent(0.0)
        }
        
        barBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        barBackgroundView.layer.cornerRadius = 15
        barBackgroundView.layer.masksToBounds = true
        
        numberBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        numberBackgroundView.layer.cornerRadius = 15
        numberBackgroundView.layer.masksToBounds = true
        
        buttonBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        buttonBackgroundView.layer.cornerRadius = 15
        buttonBackgroundView.layer.masksToBounds = true
        
        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
    }
    
    @IBAction func alert(_ sender: UIButton) {
        if set != 0 {
            for i in 0...(set - 1) {
                setBars.append(bars[i])
                setBars[i].backgroundColor = UIColor.red.withAlphaComponent(0)
            }
        }
        s = 0
        m = 0
        h = 0
        set = 0
        setBars.removeAll()

        let alert = UIAlertController(title: "시간 & 세트 설정", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alert.isModalInPopover = true
        
        let pickerFrame1 = UIPickerView(frame: CGRect(x: 20, y: 70, width: 70, height: 160))
        let pickerFrame2 = UIPickerView(frame: CGRect(x: 100, y: 70, width: 70, height: 160))
        let pickerFrame3 = UIPickerView(frame: CGRect(x: 180, y: 70, width: 70, height: 160))
        
        let set2 = UILabel(frame: CGRect(x: 40, y: 60, width: 50, height: 20))
        let count = UILabel(frame: CGRect(x: 120, y: 60, width: 50, height: 20))
        let weight = UILabel(frame: CGRect(x: 200, y: 60, width: 50, height: 20))
        
        
        alert.view.addSubview(pickerFrame1)
        alert.view.addSubview(pickerFrame2)
        alert.view.addSubview(pickerFrame3)
        
        alert.view.addSubview(set2)
        alert.view.addSubview(count)
        alert.view.addSubview(weight)
        set2.text = "세트"
        count.text = "시"
        weight.text = "분"
        
        
        pickerFrame1.dataSource = self
        pickerFrame1.delegate = self
        
        pickerFrame2.dataSource = self
        pickerFrame2.delegate = self
        
        pickerFrame3.dataSource = self
        pickerFrame3.delegate = self
        
        pickerFrame1.tag = 0
        pickerFrame2.tag = 1
        pickerFrame3.tag = 2
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: self.cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: self.ok))
        present(alert, animated: true, completion: nil )
    }

    func ok(alert: UIAlertAction) {
        let secondString = s > 9 ? "\(s)" : "0\(s)"
        let minutesString = m > 9 ? "\(m)" : "0\(m)"
        let hoursString = h > 9 ? "\(h)" : "0\(h)"
        
        stopwatchString = "\(hoursString):\(minutesString):\(secondString)"
        numberLabel.text = stopwatchString
        
        if h == 0 && m == 0 && s == 0 {
            playButtonView.isEnabled = false
            playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)

        } else {
            playButtonView.isEnabled = true
            playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }
        
        if set != 0 {
            for i in 0...(set - 1) {
                setBars.append(bars[i])
                setBars[i].backgroundColor = UIColor.red.withAlphaComponent(0.4)
            }
        }
    }
    
    func cancel(alert: UIAlertAction) {
        s = 0
        m = 0
        h = 0
        set = 0
        setBars.removeAll()
    }
    
    @IBAction func playButton(_ sender: Any) {
        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)

        timer = Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(updateStopwatch),
            userInfo: nil,
            repeats: true
        )
        
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        playButtonView.isEnabled = true
        playButtonView.setTitleColor(UIColor.white, for: UIControl.State.normal)

    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()

        playButtonView.isEnabled = false
        playButtonView.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)

        h = 0
        m = 0
        s = 0
        set = 0
        
        stopwatchString = "00:00:00"
        numberLabel.text = stopwatchString
    }
    
    @objc func updateStopwatch() {
        if set != 0 {
            update()
            set -= 1
            if set > 1 {
                for i in 0...(set - 1) {
                    setBars.append(bars[i])
                    setBars[i].backgroundColor = UIColor.red.withAlphaComponent(0.4)
                }
            }
        }
        if set == 0 {
            update()
        }
    }
    
    func update() {
        if s != 0 {
            s -= 1
            if m == 0 && h == 0 && s == 0 {
                let secondString = s > 9 ? "\(s)" : "0\(s)"
                let minutesString = m > 9 ? "\(m)" : "0\(m)"
                let hoursString = h > 9 ? "\(h)" : "0\(h)"
                
                stopwatchString = "\(hoursString):\(minutesString):\(secondString)"
                numberLabel.text = stopwatchString
                timer.invalidate()
                return
            }
            
            if s == 0 {
                if m != 0 {
                    m -= 1
                    s = 60
                }
            }
            if m == 0 {
                if h != 0 {
                    h -= 1
                    m = 59
                }
            }
        }
        
        if s == 0 {
            if m == 0 && h == 0 {
                let secondString = s > 9 ? "\(s)" : "0\(s)"
                let minutesString = m > 9 ? "\(m)" : "0\(m)"
                let hoursString = h > 9 ? "\(h)" : "0\(h)"
                
                stopwatchString = "\(hoursString):\(minutesString):\(secondString)"
                numberLabel.text = stopwatchString
                timer.invalidate()
                
                return
            }
            m -= 1
            s = 60
            s -= 1
            if s == 0 {
                if m != 0 {
                    m -= 1
                    s = 60
                }
            }
            if m == 0 {
                if h != 0 {
                    h -= 1
                    m = 59
                }
            }
        }
        
        let secondString = s > 9 ? "\(s)" : "0\(s)"
        let minutesString = m > 9 ? "\(m)" : "0\(m)"
        let hoursString = h > 9 ? "\(h)" : "0\(h)"
        
        stopwatchString = "\(hoursString):\(minutesString):\(secondString)"
        numberLabel.text = stopwatchString
    }
}

extension CountDownViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return sets.count
        case 1:
            return hours.count
        case 2:
            return minutes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return sets[row]
        case 1:
            return hours[row]
        case 2:
            return minutes[row]
        default:
            return "kkk"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            set = Int(sets[row])!
        case 1:
            h = UInt(hours[row])!
        case 2:
            m = UInt(minutes[row])!
        default:
            print("nothing")
        }
    }
    
    
}

extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
