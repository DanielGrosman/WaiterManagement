//
//  NewShiftViewController.swift
//  StaffManagement
//
//  Created by Daniel Grosman on 2018-01-28.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

class NewShiftViewController: UIViewController {
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
     var currentWaiter : Waiter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    @IBAction func saveShift(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let shiftEntity = NSEntityDescription.entity(forEntityName: "Shift", in: appDelegate?.managedObjectContext ?? NSManagedObjectContext())
        // save the shift to core data
        let newShift = Shift(entity: shiftEntity!, insertInto: appDelegate?.managedObjectContext)
        newShift.startTime = startDatePicker.date
        newShift.endTime = endDatePicker.date
        newShift.waiter = currentWaiter
        // add the shift the the waiter's list of shifts
        currentWaiter?.addShiftObject(newShift)
        do {
        try appDelegate?.managedObjectContext.save()
        }
        catch {
            print(error)
        }
        navigationController?.popViewController(animated: true)
    }
}
