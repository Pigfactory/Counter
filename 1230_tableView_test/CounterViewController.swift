//
//  CounterViewController.swift
//  1230_tableView_test
//
//  Created by PigFactory on 06/01/2019.
//  Copyright © 2019 PigFactory. All rights reserved.
//

import UIKit

class CounterViewController: UIViewController {

    @IBOutlet weak var numbersBackgroundView: UIView!
    @IBOutlet weak var numbers: UILabel!
    @IBOutlet weak var buttonBackgroundView: UIView!
    
    @IBOutlet weak var resetView: UIButton!
    @IBOutlet weak var pusView: UIButton!
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersBackgroundView.layer.cornerRadius = 15
        numbersBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        buttonBackgroundView.layer.cornerRadius = 15
        buttonBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        buttonBackgroundView.layer.masksToBounds = true
        
        resetView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
        pusView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5)
    }
    
    @IBAction func tenButton(_ sender: Any) {
        number += 10
        numberToString(number: number)
    }
    
    @IBAction func fiftyButton(_ sender: UIButton) {
        number += 50
        numberToString(number: number)
    }
    
    @IBAction func hundredButton(_ sender: Any) {
        number += 100
        numberToString(number: number)
    }

    @IBAction func resetButton(_ sender: Any) {
        number = 0
        numberToString(number: number)
    }

    @IBAction func minusButton(_ sender: Any) {
        number -= 1
        numberToString(number: number)
    }

    @IBAction func plusButton(_ sender: Any) {
        number += 1
        numberToString(number: number)
    }
    
    func numberToString(number : Int) {
        
        var a = String(number)
        
        let o = String(a.popLast() ?? "0")
        let t = String(a.popLast() ?? "0")
        let h = String(a.popLast() ?? "0")
        let t2 = String(a.popLast() ?? "0")
        
        numbers.text = "\(t2):\(h):\(t):\(o)"
    }
}
