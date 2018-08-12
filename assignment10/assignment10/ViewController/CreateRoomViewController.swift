//
//  CreateRoomViewController.swift
//  assignment6
//
//  Created by 周媛 on 3/11/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

class CreateRoomViewController: UIViewController, UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var RoomNameTextfield: UITextField!
    @IBOutlet weak var RoomTypeTextFiled: UITextField!
    @IBOutlet weak var RoomPriceTextfield: UITextField!
    
    
    let types = ["Double" , "Single"]
    var selectedType:String?
    var imageString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTypePicker()
        createToolBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
 
    
    
    // Type Picker
    func createTypePicker(){
        let typePicker = UIPickerView()
        typePicker.delegate = self as UIPickerViewDelegate
        RoomTypeTextFiled.inputView = typePicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row]
        RoomTypeTextFiled.text = selectedType
    }
    
    func createToolBar(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donebutton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        
        toolbar.setItems([donebutton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        RoomTypeTextFiled.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func BackButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Create Button
    @IBAction func CreateButtonPressed(_ sender: UIButton) {
        let price = Double(RoomPriceTextfield.text!)
        if RoomNameTextfield.text=="" || RoomTypeTextFiled.text=="" || RoomPriceTextfield.text==""{
            let alertController = UIAlertController(title: "Fialed", message: "Required Field Cannot be Empty", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if let price = price, price <= 0 {
            let alertController = UIAlertController(title: "Fialed", message: "Invalid Room Price", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        } else if RoomTypeTextFiled.text != "Double" && RoomTypeTextFiled.text != "Single"{
            let alertController = UIAlertController(title: "Fialed", message: "Invalid Room Type", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let newRoom = NSEntityDescription.insertNewObject(forEntityName: "Room", into: context)
            
            newRoom.setValue(RoomNameTextfield.text, forKey: "roomName")
            newRoom.setValue(RoomTypeTextFiled.text, forKey: "type")
            newRoom.setValue(price, forKey: "price")
            
            
            do{
                try context.save()
                print("ROOM SAVED")
            }catch{
                print("Fialed")
            }
            
            
            let alertController = UIAlertController(title: "Successful", message: "Room has been add successfully", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
            
            RoomNameTextfield.text=""
            RoomTypeTextFiled.text=""
            RoomPriceTextfield.text=""
        }
    }

}






