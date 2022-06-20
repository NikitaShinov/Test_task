//
//  LikedPhoto+CoreDataProperties.swift
//  Test_task
//
//  Created by max on 20.06.2022.
//
//

import Foundation
import CoreData


extension LikedPhoto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LikedPhoto> {
        return NSFetchRequest<LikedPhoto>(entityName: "LikedPhoto")
    }

    @NSManaged public var author: String?
    @NSManaged public var photo: String?
    @NSManaged public var downloads: String?
    @NSManaged public var location: String?
    @NSManaged public var creationDate: String?

}

extension LikedPhoto : Identifiable {

}
