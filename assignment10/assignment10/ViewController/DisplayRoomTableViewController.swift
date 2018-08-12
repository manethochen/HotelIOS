//
//  DisplayRoomTableViewController.swift
//  assignment8
//
//  Created by 周媛 on 3/22/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

var myindex = 0

class DisplayRoomTableViewController: UITableViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    var filterData = [Room]()
    var displayroom:[Room] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        getRoom()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Room List Table View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return filterData.count
        }
        return displayroom.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if isSearching{
            cell?.textLabel?.text = String(describing: filterData[indexPath.row].roomName!)
        }else{
            cell?.textLabel?.text = String(displayroom[indexPath.row].roomName!)
        }
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RoomDetailViewController{
            destination.room = displayroom[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

    // Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            let deleteObject = displayroom[indexPath.row]
            context.delete(deleteObject)
            appDelegate.saveContext()
            
            displayroom.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex=indexPath.row
    }
    
    // Get Room Data
    func getRoom(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<Room> = Room.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            try context.save()
            let searchResult = try context.fetch(fetchRequest)
            displayroom = searchResult
            if searchResult.count > 0{
                for result:Room in searchResult {
                    print("room name = \(result.roomName)")
                }
                
            }
        } catch{
        }
    }
    
    // Search Bar Function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            tableView.reloadData()
        } else{
            isSearching = true
            filterData = displayroom.filter({($0.roomName?.lowercased().contains(searchBar.text!.lowercased()))!})
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
