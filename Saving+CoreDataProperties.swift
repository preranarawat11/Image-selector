//
//  Saving+CoreDataProperties.swift
//  Image-selector
//
//  Created by Prerana on 19/11/22.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var name: String?
    @NSManaged public var imageD: Data?
    @NSManaged public var profileImg: Data?
    @NSManaged public var favourite: Int64
    @NSManaged public var detail: String?
    @NSManaged public var date: Date?

}

extension Saving : Identifiable {

}
