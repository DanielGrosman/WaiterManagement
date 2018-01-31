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
    
    let monthDateFormatter = DateFormatter()
    let dayDateFormatter = DateFormatter()
    let yearDateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shifts = Array(waiter.shifts)
        setupDateFormatters()
        sortShifts()
        tableView.reloadData()
        self.navigationItem.title = "\(self.waiter.name!)'s Shifts"
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
    }
    
    func setupDateFormatters () {
        monthDateFormatter.dateFormat = "LLLL"
        dayDateFormatter.dateFormat = "dd"
        yearDateFormatter.dateFormat = "YYYY"
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.dateStyle = DateFormatter.Style.none
    }
    
    func sortShifts() {
        shifts.sort() { ($1 as AnyObject).startTime > ($0 as AnyObject).startTime }
    }
    
    // MARK: - TableView Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShiftTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "shiftCell", for: indexPath) as? ShiftTableViewCell
        
        let currentShift = shifts[indexPath.row]
        
        cell?.shiftMonthLabel.text = monthDateFormatter.string(from: (currentShift as AnyObject).startTime)
        cell?.shiftDateLabel.text = dayDateFormatter.string(from: (currentShift as AnyObject).startTime)
        cell?.shiftYearLabel.text = yearDateFormatter.string(from: (currentShift as AnyObject).startTime)
        cell?.shiftTimeLabel.text = "\(timeFormatter.string(from: (currentShift as AnyObject).startTime)) - \(timeFormatter.string(from: (currentShift as AnyObject).endTime))"

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addShift") {
            let vc = segue.destination as? NewShiftViewController
            vc?.currentWaiter = self.waiter
        }
    }
    
}
