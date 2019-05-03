//
//  Profile+CoreDataProperties.swift
//  335 Project Zoo
//
//  Created by Alejandro Rayas on 4/12/19.
//  Copyright © 2019 Alejandro Rayas. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var diary: String?
    @NSManaged public var name: String?
    @NSManaged public var picture: Data?

}
