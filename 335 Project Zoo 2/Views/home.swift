//
//  home.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/10/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import Contacts
import MapKit

class home: UIViewController, CLLocationManagerDelegate{
    var latitude: String!
    var longitude: String!
    var Lat:String!
    var Long:String!
    var manager:CLLocationManager!
    var coords1: CLLocationCoordinate2D?
    var coords2: CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile"{
            let test = segue.destination as! profile
        }
        else{

        }
    }
}
