//
//  BookingDetailViewController.swift
//  assignment8
//
//  Created by 周媛 on 3/22/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

class BookingDetailViewController: UIViewController {

    @IBOutlet weak var bookingNameTxt: UILabel!
    @IBOutlet weak var checkinTxt: UILabel!
    @IBOutlet weak var checkoutTxt: UILabel!
    @IBOutlet weak var customerNameTxt: UILabel!
    @IBOutlet weak var roomNameTxt: UILabel!
    
    var booking:Booking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let checkindate:String = dateFormatter.string(from: booking?.checkinDate! as! Date)
        let checkoutdate:String = dateFormatter.string(from: booking?.checkoutDate! as! Date)

        bookingNameTxt.text = booking?.bookingName
        checkinTxt.text = checkindate
        checkoutTxt.text = checkoutdate
        customerNameTxt.text = booking?.customer
        roomNameTxt.text = booking?.room
        
//        bookingDetailText.isEditable = false
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest:NSFetchRequest<Booking> = Booking.fetchRequest()
//        fetchRequest.returnsObjectsAsFaults = false
//        do {
//            try context.save()
//            let searchResult = try context.fetch(fetchRequest)
//            bookingNameTxt.text = "\(searchResult[bookingIndex].bookingName!)  \(searchResult[bookingIndex].checkinDate!) \n \(searchResult[bookingIndex].checkoutDate!) \(searchResult[bookingIndex].customer!) \(searchResult[bookingIndex].room!)"
//
//
//        } catch{
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
