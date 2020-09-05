//
//  Card+CoreDataProperties.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var back: Data
    @NSManaged public var createdAt: Date
    @NSManaged public var front: Data
    @NSManaged public var id: UUID
    @NSManaged public var spacedRep: SRepData
    @NSManaged public var tagDeck: TagDeck?

}

extension Card : Identifiable {

}
