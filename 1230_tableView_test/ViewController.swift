//
//  ViewController.swift
//  1230_tableView_test
//
//  Created by PigFactory on 30/12/2018.
//  Copyright © 2018 PigFactory. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var items = ["이름 1"]

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func add(_ sender: Any) {
        items.append("이름 \(items.count + 1)")
        
        let insertionIndexPath = NSIndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [insertionIndexPath as IndexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func Delete(cell: UITableViewCell) {
        if let deleteIndexPath = tableView.indexPath(for: cell) {
            items.remove(at: deleteIndexPath.row)
            tableView.deleteRows(at: [deleteIndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        myCell.labelView.text = items[indexPath.row]
        
        //Q1> 이건뭐???
        myCell.viewController = self
        
        return myCell
    }
}

