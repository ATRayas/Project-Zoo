//
//  ProfileModel.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/10/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData
import Foundation
public class ProfileModel
{
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var   fetchResults =   [Profile]()
    
    func fetchRecord() -> Int {
        // Create a new fetch request using the Profile
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        var x   = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [Profile])!
        
        print(fetchResults)
        
        x = fetchResults.count
        
        print(x)
        
        // return howmany entities in the coreData
        return x
        
        
    }
    
    func addStory(x:String, y:String, z: UIImage)
    {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "Profile", in: self.managedObjectContext)
        //add to the manege object context
        let newItem = Profile(entity: ent!, insertInto: self.managedObjectContext)
        newItem.name = x
        newItem.diary = y
        let imageData = z.pngData()
        newItem.picture = imageData!
        
        // save the updated context
        do {
            try self.managedObjectContext.save()
        } catch _ {
        }
        
        print(newItem)
    }
    
    func removeEntry(row:Int)
    {
        managedObjectContext.delete(fetchResults[row])
        // remove it from the fetch results array
        fetchResults.remove(at:row)
        
        do {
            // save the updated managed object context
            try managedObjectContext.save()
        } catch {
            
        }
        
    }
    
    func getEntryObject(row:Int) -> Profile
    {
        return fetchResults[row]
    }
}

