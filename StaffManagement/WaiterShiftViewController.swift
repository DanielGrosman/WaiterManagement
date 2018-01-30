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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
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
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.long
        cell?.startDate.text = dateFormatter.string(from: (currentShift as AnyObject).startTime)
        cell?.endDate.text = dateFormatter.string(from: (currentShift as AnyObject).endTime)
        
        let timeFormatter = DateFormatter ()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateStyle = DateFormatter.Style.none
        cell?.startTime.text = timeFormatter.string(from: (currentShift as AnyObject).startTime)
        cell?.endTime.text = timeFormatter.string(from: (currentShift as AnyObject).endTime)

        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addShift") {
            let vc = segue.destination as? NewShiftViewController
            vc?.currentWaiter = self.waiter
        }
    }
    
    
    
}
