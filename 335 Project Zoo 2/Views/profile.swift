//
//  profile.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/10/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData

class profile: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var x:String?
    var y:String?
    var z:UIImage?
    //var fetchResults = [profile]()
    var counter = 1
    @IBOutlet weak var diaryTable: UITableView!
    
    var pm:ProfileModel = ProfileModel();
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of rows based on the coredata storage
        return pm.fetchRecord()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        
        let rowdata = pm.getEntryObject(row: indexPath.row)//getFruitObject(row: indexPath.row)
        cell.textLabel?.text = rowdata.name
        return cell
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            pm.removeEntry(row: indexPath.row)
            // reload the table after deleting a row
            diaryTable.reloadData()
        }
        
    }
    
    @IBAction func addARecord(_ sender: UIBarButtonItem) {
        alertPop()
        // reload the table with added row
        diaryTable.reloadData()
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        picker .dismiss(animated: true, completion: nil)
        z = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        self.pm.addStory(x: self.x!, y: self.y!, z: self.z!)
        // reload the table with added row
        self.diaryTable.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.diaryTable.indexPath(for: sender as! UITableViewCell)!
        
        let entry = pm.fetchResults[selectedIndex.row]
        
        if(segue.identifier == "profileDetailView"){
            let test: profileDetail = segue.destination as! profileDetail
            test.selectedImage = entry.picture
            test.diaryTextInput = entry.diary
            test.titleText = entry.name
        }
    }
    func updateLastRow() {
        let indexPath = IndexPath(row: pm.fetchResults.count - 1, section: 0)
        diaryTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
    
    func alertPop(){
        
        let alert = UIAlertController(title: "Memory entry", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter name of the entry here"
        })
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter description of the experience"
        })
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //one more item added
            self.updateCounter()
            let innerAlert = UIAlertController(title: "Now please choose to either take a picture or use a picture from your library for your entry", message: nil, preferredStyle: .alert)
            innerAlert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                print("tried")
                let photoPicker = UIImagePickerController ()
                photoPicker.delegate = self
                photoPicker.sourceType = .photoLibrary
                // display image selection view
                self.present(photoPicker, animated: true, completion: nil)
            }))
            innerAlert.addAction(UIAlertAction(title: "Take a Photo", style: .default, handler: { action in
                print("hello")
                let photoPicker = UIImagePickerController ()
                photoPicker.delegate = self
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    photoPicker.sourceType = .camera
                    self.present(photoPicker, animated: true, completion: nil)
                }
                else{
                    print("camera is not present")
                }
            }))
            self.present(innerAlert, animated: true)
            // Do this first, then use method 1 or method 2
            if let name = alert.textFields?.first?.text, let descr = alert.textFields?.last?.text {
                print("Your Entry name: \(name)")
                self.x = name
                self.y = descr
                print("Your Entry description: \(descr)")
                
            }
        }))
        
        self.present(alert, animated: true)
    }
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}
