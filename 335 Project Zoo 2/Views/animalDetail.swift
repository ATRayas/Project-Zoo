//
//  animalDetail.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/10/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData

class animalDetail: UIViewController{
    var selectedAnimal:String?
    var selectedAnimalImage:String?
    var facts:String?
    var pageidHolder:String?
    @IBOutlet weak var animalPicture: UIImageView!
    @IBOutlet weak var AnimalName: UINavigationItem!
    @IBOutlet weak var AnimalFacts: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnimalFacts.isHidden = true
        AnimalFacts.isEditable = false
        animalPicture.image = UIImage(named: selectedAnimalImage!)
        AnimalName.title = selectedAnimal
        initalCall()
        
        
    }
    func finalCall(){
        let urlAsString = "https://animals.fandom.com/api/v1/Articles/AsSimpleJson?id="+pageidHolder!
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            //print(jsonResult)
            let setOne:NSArray = jsonResult["sections"] as! NSArray
            let y = setOne[0] as? [String: AnyObject]
            let setTwo:NSArray = y?["content"] as! NSArray
            let z = setTwo[0] as? [String:AnyObject]
            print(setTwo);
            DispatchQueue.main.async{
                self.AnimalFacts.text = (z!["text"]) as? NSString as! String
                self.AnimalFacts.isHidden = false
            }
        })
        jsonQuery.resume()
    }
    func initalCall(){
        if selectedAnimal == "Giraffe"{
            
        }
        else if selectedAnimal == "Alligator"{
            selectedAnimal = "American_Alligator"
        }
        else if selectedAnimal == "Zebra"{
            
        }
        else if selectedAnimal == "Lion"{
            
        }
        else if selectedAnimal == "Osprey"{
            
        }
        else if selectedAnimal == "Cougar"{
            
        }
        else if selectedAnimal == "Elephant"{
            selectedAnimal = "African_elephant"
        }
        //cityDescrip.text = selectedCityDescription
        let urlAsString = "https://animals.fandom.com/api.php?action=query&prop=images&titles="+selectedAnimal!+"&format=json"
        let url = URL(string: urlAsString)!
        let urlSession = URLSession.shared
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            var err: NSError?
            
            
            var jsonResult = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            if (err != nil) {
                print("JSON Error \(err!.localizedDescription)")
            }
            
            //print(jsonResult)
            let setOne:NSDictionary = jsonResult["query"] as! NSDictionary
            let setTwo:NSDictionary = setOne["pages"] as! NSDictionary
            let childDictionary = setTwo.allValues.first as? NSDictionary
            let pageID:Int = Int((childDictionary!["pageid"] as? NSNumber)!.int64Value)
            let page:String = String(pageID)
            self.pageidHolder = page
            print(page);
            self.finalCall()
        })
        jsonQuery.resume()
    }
}
