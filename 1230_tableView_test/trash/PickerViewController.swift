//
//  PickerViewController.swift
//  1230_tableView_test
//
//  Created by PigFactory on 30/12/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    let set = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @IBOutlet weak var setPicker: UIPickerView!
    
    @IBOutlet weak var countPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPicker.delegate = self
        setPicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
    }

}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return set.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(set[row])
    }
    
    
}
