//
//  WaiterShiftViewController.swift
//  StaffManagement
//
//  Created by Daniel Grosman on 2018-01-28.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

class WaiterShiftViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var shifts = [Any]()
    var waiter = Waiter ()
    var waiterName = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shifts = Array(waiter.shifts)
        tableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShiftTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "shiftCell", for: indexPath) as? ShiftTableViewCell 
        let currentShift = shifts[indexPath.row]
        let dateFormatter = DateFormatter ()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let startDateString = dateFormatter.string(from: (currentShift as AnyObject).startTime)
        let endDateString = dateFormatter.string(from: (currentShift as AnyObject).endTime)
        cell?.startLabel.text = startDateString
        cell?.endLabel.text = endDateString
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addShift") {
            let vc = segue.destination as? NewShiftViewController
            vc?.currentWaiter = self.waiter
        }
    }
    
    
    
}
