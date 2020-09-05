//
//  TagDeck+CoreDataProperties.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//
//

import Foundation
import CoreData
import UIKit


extension TagDeck {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<TagDeck> {
		return NSFetchRequest<TagDeck>(entityName: "TagDeck")
	}
	
	@NSManaged public var name: String
	@NSManaged public var id: UUID
	@NSManaged public var color: Data
	@NSManaged public var createdAt: Date
	@NSManaged public var cards: NSSet
	@NSManaged public var children: NSSet
	@NSManaged public var parent: TagDeck?
	
}

// MARK: Generated accessors for cards
extension TagDeck {
	
	@objc(addCardsObject:)
	@NSManaged public func addToCards(_ value: Card)
	
	@objc(removeCardsObject:)
	@NSManaged public func removeFromCards(_ value: Card)
	
	@objc(addCards:)
	@NSManaged public func addToCards(_ values: NSSet)
	
	@objc(removeCards:)
	@NSManaged public func removeFromCards(_ values: NSSet)
	
}

// MARK: Generated accessors for children
extension TagDeck {
	
	@objc(addChildrenObject:)
	@NSManaged public func addToChildren(_ value: TagDeck)
	
	@objc(removeChildrenObject:)
	@NSManaged public func removeFromChildren(_ value: TagDeck)
	
	@objc(addChildren:)
	@NSManaged public func addToChildren(_ values: NSSet)
	
	@objc(removeChildren:)
	@NSManaged public func removeFromChildren(_ values: NSSet)
	
}

extension TagDeck : Identifiable {
	
}
