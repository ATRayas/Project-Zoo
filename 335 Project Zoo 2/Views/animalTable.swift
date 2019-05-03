//
//  animalTable.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/10/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData

class animalTable: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate{
    @IBOutlet weak var animalTable: UITableView!
    var myAnimalList:AnimalsInit = AnimalsInit()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myAnimalList.Animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! AnimalCell
        cell.layer.borderWidth = 1.0
        cell.AnimalName.text = myAnimalList.Animals[indexPath.row].animalName
        cell.AnimalImageView.image = UIImage(named: myAnimalList.Animals[indexPath.row].animaImageName!)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.animalTable.indexPath(for: sender as! UITableViewCell)!
        
        let block = myAnimalList.Animals[selectedIndex.row] //[selectedIndex.row]
        
        
        
        if(segue.identifier == "detailView"){
            let test: animalDetail = segue.destination as! animalDetail
            test.selectedAnimal = block.animalName;
            test.selectedAnimalImage = block.animaImageName
        }
    }
    
}
