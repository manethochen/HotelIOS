//
//  AddCustomerViewController.swift
//  assignment6
//
//  Created by Jiayuan Chen on 3/11/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

class AddCustomerViewController: UIViewController {

    var displayCustomer:[String] = []

    
    @IBOutlet weak var viewContainer: UILabel!
    @IBOutlet weak var NameTextfield: UITextField!
    @IBOutlet weak var AddressTextfield: UITextField!
    @IBOutlet weak var IDTextfield: UITextField!
    @IBOutlet weak var PhoneTextfield: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setLayout()
    }

    func setLayout(){
        viewContainer.contentMode = .scaleAspectFit
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
   
    @IBAction func CreateButtonPressed(_ sender: UIButton) {
        if NameTextfield.text=="" || AddressTextfield.text=="" || IDTextfield.text=="" || PhoneTextfield.text==""{
            let alertController = UIAlertController(title: "Fialed", message: "Required Field Cannot be Empty", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if Int(IDTextfield.text!) == nil{
            let alertController = UIAlertController(title: "Fialed", message: "ID Number Must be Number!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if PhoneTextfield.text?.count != 10 || Int(PhoneTextfield.text!)==nil{
            let alertController = UIAlertController(title: "Fialed", message: "Invalid Phone Number", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newCutomer = NSEntityDescription.insertNewObject(forEntityName: "Customer", into: context)
            
            newCutomer.setValue(NameTextfield.text, forKey: "name")
            newCutomer.setValue(AddressTextfield.text, forKey: "address")
            newCutomer.setValue(Int(IDTextfield.text!), forKey: "id")
            newCutomer.setValue(Int(PhoneTextfield.text!), forKey: "phoneNumber")
            
            let fetchRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                try context.save()
                print("CUSTOMER SAVED")
                
                let searchResult = try context.fetch(fetchRequest)
                if searchResult.count > 0{
                    for result in searchResult as [NSManagedObject]{
                        if let customer = result.value(forKey: "name") as? String, let address = result.value(forKey: "address") as? String {
                            displayCustomer.append(customer)
                            displayCustomer.append(address)
                            //DisplayRoomTextView.text = "\(room)  \(type)  \(price) \n"
                        }
                        
                    }
                    print(displayCustomer)
                }
            }catch{
                
            }

            
            let alertController = UIAlertController(title: "Successful", message: "Customer has been added successfully!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
            NameTextfield.text = ""
            AddressTextfield.text = ""
            IDTextfield.text = ""
            PhoneTextfield.text = ""
        }
        
    }
}







