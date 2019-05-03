//
//  directions.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/10/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class directions: UIViewController{
    @IBOutlet weak var searchBox: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        let geoCoder = CLGeocoder();
        let addressString = "Phoenix Arizona"
        //let addressString = cityName.text!
        CLGeocoder().geocodeAddressString(addressString, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    print(location)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    self.zoo()
                    
                    
                }
        })
    }
    func zoo(){
        let geoCoder = CLGeocoder();
        let addressString = "Phoenix Zoo"
        //let addressString = cityName.text!
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = addressString//"pizza"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            
            print( response.mapItems )
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            let place = matchingItems[0].placemark
            let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: place.location!.coordinate, span: span)
            self.map.setRegion(region, animated: true)
            let ani = MKPointAnnotation()
            ani.coordinate = place.location!.coordinate
            ani.title = place.name
            ani.subtitle = place.subLocality
            self.map.addAnnotation(ani)
            print(place.location?.coordinate.latitude)
            print(place.location?.coordinate.longitude)
            print(place.name)
        }
    }
    @IBAction func showMap(_ sender: Any) {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
            //case 2:
            //    map.mapType = MKMapType.hybrid
            
        default:
            map.mapType = MKMapType.standard
        }
    }
    @IBAction func searchButton(_ sender: UIButton) {
        map.removeAnnotations(map.annotations)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.searchBox.text//"pizza"
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print( response.mapItems )
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            if matchingItems.count > 1{
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                //ani.subtitle = place.subLocality
                
                self.map.addAnnotation(ani)
                print(place.location?.coordinate.latitude)
                print(place.location?.coordinate.longitude)
                print(place.name)
                
            }
            }
            else{
                let place = matchingItems[0].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                self.map.addAnnotation(ani)
                print(place.location?.coordinate.latitude)
                print(place.location?.coordinate.longitude)
                print(place.name)
            }
            
        }
    }
    
}

extension UIViewController{
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}

