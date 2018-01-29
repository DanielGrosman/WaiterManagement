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
    
    var currentWaiter = Waiter ()
    var startDateString = String ()
    var endDateString = String ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func saveShift(_ sender: Any) {
        
        var appDelegate = UIApplication.shared.delegate as? AppDelegate
        var error: Error? = nil
        var shiftEntity = NSEntityDescription.entity(forEntityName: "Shift", in: appDelegate?.managedObjectContext ?? NSManagedObjectContext())
        var newShift = Shift(entity: shiftEntity!, insertInto: appDelegate?.managedObjectContext)
        newShift.startTime = startDatePicker.date
        newShift.endTime = endDatePicker.date
        newShift.waiter = currentWaiter
        currentWaiter.addShiftObject(newShift)
        do {
        try appDelegate?.managedObjectContext.save()
        }
        catch {
            print(error)
        }
        dismiss(animated: true) {() -> Void in }
    }
    
}
