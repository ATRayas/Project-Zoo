//
//  AnimalsInit.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/9/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//

import Foundation

class AnimalsInit{
    var Animals:[animal] = []
    
    init()
    {
        let c1 = animal(an: "Zebra",ain: "zebra.jpg")
        let c2 = animal(an: "Giraffe",ain: "giraffe.jpg")
        let c3 = animal(an: "Lion",ain: "lion.jpg")
        let c4 = animal(an: "Elephant",ain: "elephant.jpg")
        let c5 = animal(an: "Alligator",ain: "aligator.jpg")
        let c6 = animal(an: "Osprey",ain: "Osprey.jpg")
        let c7 = animal(an: "Cougar",ain: "Cougar.jpg")
        
        Animals.append(c1)
        Animals.append(c2)
        Animals.append(c3)
        Animals.append(c4)
        Animals.append(c5)
        Animals.append(c6)
        Animals.append(c7)
    }
}
class animal{
    var animalName:String?
    var animaImageName:String?
    
    init(an:String, ain:String) {
        animalName = an
        animaImageName = ain
    }
}
