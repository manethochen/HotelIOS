//
//  CreateBookingViewController.swift
//  assignment6
//
//  Created by 周媛 on 3/11/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

class CreateBookingViewController: UIViewController,AccessoryToolbarDelegate{
    
    @IBOutlet weak var BookingNameTextfield: UITextField!
    @IBOutlet weak var checkinTextField: UITextField!
    @IBOutlet weak var checkoutTextField: UITextField!
    @IBOutlet weak var CustomerNameTextfield: UITextField!
    @IBOutlet weak var RoomNameTextfield: UITextField!

    var rooms:[Room] = []
    var customers:[Customer] = []

    let dateformatter=DateFormatter()
    var selectRoom:Room?
    var selectCustomer:Customer?
    
    let dateFomatter = DateFormatter()
    let datePicker = UIDatePicker()
    let curdate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker(textfield: checkinTextField)
        createDatePicker(textfield: checkoutTextField)
        getRoom()
        getCustomer()
        CreateRoomPicker()
        CreateCustomerPicker()
        
    }

    
    func createDatePicker(textfield: UITextField){
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
        let toolbar = AccessoryToolbar(for: textfield)
        toolbar.accessoryDelegate = self 
        toolbar.sizeToFit()
        
        textfield.inputAccessoryView = toolbar
        textfield.inputView = datePicker

    }
    

    func doneClicked(for textField: UITextField) {
        // formate date
        dateFomatter.dateFormat = "YYYY-MM-dd"
        textField.text = dateFomatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @IBAction func BackButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func CreateButtonPressed(_ sender: UIButton) {
        let customercheck_flag = checkCustomer(customerName: CustomerNameTextfield.text!)
        let roomcheck_flag = checkRoom(roomName: RoomNameTextfield.text!)
        
        if BookingNameTextfield.text=="" || checkinTextField.text=="" || checkoutTextField.text=="" || CustomerNameTextfield.text=="" || RoomNameTextfield.text==""{
            let alertController = UIAlertController(title: "Fialed", message: "Required Field Cannot be Empty", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }else if dateFomatter.date(from: checkinTextField.text!)==nil && dateFomatter.date(from: checkoutTextField.text!)==nil{
            let alertController = UIAlertController(title: "Fialed", message: "Invalid Date Format", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if Double((dateFomatter.date(from: checkoutTextField.text!)?.timeIntervalSince(dateFomatter.date(from: checkinTextField.text!)!))!) < 84600{
            let alertController = UIAlertController(title: "Fialed", message: "Please Input at Least ONE day", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if customercheck_flag == false{
            let alertController = UIAlertController(title: "Failed", message: "Customer Not Exist!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if roomcheck_flag == false{
            let alertController = UIAlertController(title: "Failed", message: "Room Not Exist!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newBooking = NSEntityDescription.insertNewObject(forEntityName: "Booking", into: context)
            
            newBooking.setValue(BookingNameTextfield.text, forKey: "bookingName")
            newBooking.setValue(dateFomatter.date(from: checkinTextField.text!) , forKey: "checkinDate")
            newBooking.setValue(dateFomatter.date(from: checkoutTextField.text!) , forKey: "checkoutDate")
            newBooking.setValue(CustomerNameTextfield.text, forKey: "customer")
            newBooking.setValue(RoomNameTextfield.text, forKey: "room")
            
            do{
                try context.save()
                print("BOOKING SAVED")
            }catch{
                
            }
            
            
            
            let alertController = UIAlertController(title: "Successful", message: "Booking has been create successfully!", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
            BookingNameTextfield.text = ""
            checkinTextField.text = ""
            checkoutTextField.text = ""
            CustomerNameTextfield.text = ""
            RoomNameTextfield.text = ""
        }
    }
    
    func checkCustomer(customerName:String) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let customerRequest:NSFetchRequest<Customer> = Customer.fetchRequest()
        customerRequest.returnsObjectsAsFaults = false
        do {
            let customerSearchResult = try context.fetch(customerRequest)
            for result in customerSearchResult as [NSManagedObject]{
                if let customer = result.value(forKey: "name") as? String, customerName == customer {
                    print(customer)
                    return true
                }
            }
            
        }catch{
            
        }
          return false
    }
    
    func checkRoom(roomName:String) -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let roomRequest:NSFetchRequest<Room> = Room.fetchRequest()
        roomRequest.returnsObjectsAsFaults = false
        
        do {
            let roomSearchResult = try context.fetch(roomRequest)
            for result in roomSearchResult as [NSManagedObject]{
                if let room = result.value(forKey: "roomName") as? String, roomName == room {
                    print(room)
                    return true
                }
            }
            
        }catch{
            
        }
        return false
        
    }
    
    func getRoom(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Room>(entityName:"Room")
        request.returnsObjectsAsFaults = false
        do{
            let fetchedObjects = try context.fetch(request)
            rooms = fetchedObjects
            for room in rooms{
                print("room:\(String(describing: room.roomName))")
            }
        }catch{
            print("Could not fetch \(error)")
        }
    }
    
    func getCustomer(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<Customer>(entityName: "Customer")
        request.returnsObjectsAsFaults = false
        do{
            let fetchedObjects = try context.fetch(request)
            customers = fetchedObjects
            for customer in customers{
                print("customer:\(customer.name)")
            }
        }catch{
            
        }
    }
    
    func CreateRoomPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.roomDonePressed))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        RoomNameTextfield.inputAccessoryView = toolbar
        
        let roomPicker = UIPickerView()
        roomPicker.delegate = self as UIPickerViewDelegate
        roomPicker.tag = 0
        RoomNameTextfield.inputView = roomPicker
    }
    
    @objc func roomDonePressed(){
        view.endEditing(true)
    }
    
    func CreateCustomerPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.customerDonePressed))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        CustomerNameTextfield.inputAccessoryView = toolbar
        
        let customerPicker = UIPickerView()
        customerPicker.delegate = self as! UIPickerViewDelegate
        customerPicker.tag = 1
        CustomerNameTextfield.inputView = customerPicker
    }
    @objc func customerDonePressed(){
        view.endEditing(true)
    }
 
    
    
}


protocol AccessoryToolbarDelegate: class {
    func doneClicked(for textField: UITextField)
}

class AccessoryToolbar: UIToolbar {
    
    fileprivate let textField: UITextField
    
    weak var accessoryDelegate: AccessoryToolbarDelegate?
    
    init(for textField: UITextField) {
        self.textField = textField
        super.init(frame: CGRect.zero)
        
        self.barStyle = .default
        self.isTranslucent = true
        self.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        self.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        self.setItems([doneButton], animated: false)
        self.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func doneClicked() {
        accessoryDelegate?.doneClicked(for: self.textField)
    }
    
    
    
}




extension CreateBookingViewController :UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag==0){
            return rooms.count
        }
        else{
            return customers.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag==0){
            return rooms[row].roomName
        }
        else{
            return customers[row].name
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag==0){
            selectRoom = rooms[row]
            RoomNameTextfield.text=selectRoom?.roomName
        }
        else{
            selectCustomer=customers[row]
            CustomerNameTextfield.text=selectCustomer?.name
        }
        
    }
 
}











