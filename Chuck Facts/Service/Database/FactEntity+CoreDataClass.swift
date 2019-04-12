//
//  FactEntity+CoreDataClass.swift
//  
//
//  Created by Luiz Fernando dos Santos on 11/04/19.
//
//

import Foundation
import CoreData

@objc(FactEntity)
public class FactEntity: NSManagedObject {

    static func save(fact: Fact?, persistence: PersistenceManager) {

        let entity = FactEntity(context: persistence.context)
        entity.id = fact?.id
        entity.url = fact?.url
        entity.value = fact?.value
        entity.icon_url = fact?.icon_url
        entity.category = fact?.category

        persistence.save()

    }
}
