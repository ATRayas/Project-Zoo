//
//  profileDetail.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/12/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import UIKit
import CoreData

class profileDetail: UIViewController{
    @IBOutlet weak var diaryImage: UIImageView!
    @IBOutlet weak var diaryText: UITextView!
    @IBOutlet weak var diaryTitle: UILabel!
    var selectedImage:Data?
    var diaryTextInput:String?
    var titleText:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        diaryText.text = diaryTextInput
        diaryTitle.text = titleText
        if selectedImage != nil{
            let pic: UIImage = UIImage(data: selectedImage!)!
            diaryImage.image = pic//UIImage(named: selectedCityImage!)
        }
        else{
            diaryImage.image = UIImage(named: "city.jpg")
        }
    }
    
    
}
