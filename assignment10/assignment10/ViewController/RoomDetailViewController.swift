//
//  RoomDetailViewController.swift
//  assignment8
//
//  Created by 周媛 on 3/22/18.
//  Copyright © 2018 yuanyuanzhou. All rights reserved.
//

import UIKit
import CoreData

class RoomDetailViewController: UIViewController {

    @IBOutlet weak var roomTxt: UILabel!
    @IBOutlet weak var typeTxt: UILabel!
    @IBOutlet weak var priceTxt: UILabel!
    @IBOutlet weak var roomImage: UIImageView!
    var room:Room?
    let roomsImage:[String] = ["room1", "room2", "room3","room4","room5","room6","room7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomTxt.text = room?.roomName
        typeTxt.text = room?.type
        priceTxt.text = "$ \((room?.price)!)"
        roomImage.image = UIImage(named: roomsImage[myindex])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
