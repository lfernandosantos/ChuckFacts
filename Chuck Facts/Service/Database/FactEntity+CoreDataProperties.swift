//
//  FactEntity+CoreDataProperties.swift
//  
//
//  Created by Luiz Fernando dos Santos on 11/04/19.
//
//

import Foundation
import CoreData


extension FactEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FactEntity> {
        return NSFetchRequest<FactEntity>(entityName: "FactEntity")
    }

    @NSManaged public var category: [String]?
    @NSManaged public var icon_url: String?
    @NSManaged public var id: String?
    @NSManaged public var url: String?
    @NSManaged public var value: String?

}
