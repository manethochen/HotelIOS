//
//  TableViewController.swift
//  TEST
//
//  Created by Jiayuan Chen on 3/20/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
   let elements = ["Add Customer", "Create Room", "Display Room", "Create Booking", "Display Booking"]
    let identities:[String] = ["AddCustomer", "CreateRoom","DisplayRoom", "CreateBooking", "DisplayBooking"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    func openAddCustomerViewController(){
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController:AddCustomerViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddCustomer") as! AddCustomerViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        self.splitViewController?.showDetailViewController(navigationController, sender: self)
    }

    func openCreateRoomViewController(){
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController:CreateRoomViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateRoom") as! CreateRoomViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        self.splitViewController?.showDetailViewController(navigationController, sender: self)
    }
    
    func openDisplayRoomViewController(){
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController:DisplayRoomTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayRoom") as! DisplayRoomTableViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        self.splitViewController?.showDetailViewController(navigationController, sender: self)
    }
    
    func openCreateBookingViewController(){
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController:CreateBookingViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateBooking") as! CreateBookingViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        self.splitViewController?.showDetailViewController(navigationController, sender: self)
    }
    
    func openDisplayBookingViewController(){
        self.splitViewController?.preferredDisplayMode = .automatic
        let viewController:DisplayBookingTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DisplayBooking") as! DisplayBookingTableViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        self.splitViewController?.showDetailViewController(navigationController, sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        cell.menuLabel.text = elements[indexPath.row]
        cell.menuImage.image = UIImage(named: elements[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = identities[indexPath.row]
        if vcName == "AddCustomer"{
            self.openAddCustomerViewController()
        } else if vcName == "CreateRoom"{
            self.openCreateRoomViewController()
        } else if vcName == "DisplayRoom"{
            self.openDisplayRoomViewController()
        } else if vcName == "CreateBooking"{
            self.openCreateBookingViewController()
        } else{
            self.openDisplayBookingViewController()
        }
        //let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        //self.navigationController?.pushViewController(viewController!, animated: true)
    }
  
}





