//
//  DisplayBookingTableViewController.swift
//  assignment8
//
//  Created by 周媛 on 3/22/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

var bookingIndex = 0
class DisplayBookingTableViewController: UITableViewController,UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    var displaybooking:[Booking] = []
    var isSearching = false
    var filterData = [Booking]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        getBooking()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // Get Booking Data
    func getBooking(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Booking> = Booking.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            try context.save()
            let searchResult = try context.fetch(fetchRequest)
            if searchResult.count > 0{
                for result in searchResult as [NSManagedObject]{
                    displaybooking.append(result as! Booking)
                }
                
                print(displaybooking)
            }
        } catch{
        }
    }
    
    // Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterData.count
        }
        return displaybooking.count
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if isSearching{
            cell?.textLabel?.text = String(describing: filterData[indexPath.row].bookingName)
        }else{
            cell?.textLabel?.text = String(displaybooking[indexPath.row].bookingName!)
        }
        return cell!
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookingIndex=indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookingDetailViewController{
            destination.booking = displaybooking[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    // delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            let deleteObject = displaybooking[indexPath.row]
            context.delete(deleteObject)
            appDelegate.saveContext()
            displaybooking.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    
    
    // search
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            tableView.reloadData()
        } else{
            isSearching = true
            filterData = displaybooking.filter({($0.bookingName?.lowercased().contains(searchBar.text!.lowercased()))!})
            tableView.reloadData()
        }
    }
    

    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
