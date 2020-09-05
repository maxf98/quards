//
//  DataModel.swift
//  Quards
//
//  Created by Max Fest on 03.08.20.
//

import Foundation
import CoreData
import UIKit

class QuardsModel: ObservableObject {
	
	var coreDataStack = CoreDataStack(modelName: "QuardsModel")
		
	init() {
	}
	
	func getRoots() -> [TagDeck] {
		let fetchRequest: NSFetchRequest<TagDeck> = TagDeck.fetchRequest()
		let predicate = NSPredicate(format: "%K == nil", (\TagDeck.parent)._kvcKeyPathString!) // this is a workaround right now, throwing an error where it shouldn't really
		fetchRequest.predicate = predicate
		
		var results = [TagDeck]()
		
		do {
			results = try coreDataStack.managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		
		return results
	}
	
	func getDecksFromStore() -> [TagDeck] {
		let fetchRequest: NSFetchRequest<TagDeck> = TagDeck.fetchRequest()
		
		var results = [TagDeck]()
		
		do {
			results = try coreDataStack.managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		
		return results
	}
	
	func createTagDeck(parent: TagDeck?) -> TagDeck {
		var deck: TagDeck
		if let par = parent {
			deck = TagDeck.newInstance(deck: par, context: coreDataStack.managedContext)
		} else {
			deck = TagDeck.newRoot(context: coreDataStack.managedContext)
		}
		coreDataStack.saveContext()
		return deck
	}
	
	// not sure this is safe right now, but I'm excited to see what happens when I do this
	func deleteDeck(deck: TagDeck) {
		for child in deck.wrappedChildren {
			child.parent = deck.parent
		}
		coreDataStack.managedContext.delete(deck)
		coreDataStack.saveContext()
	}
	
	func addNewCard(deck: TagDeck) -> Card {
		let card = Card.newInstance(deck: deck, context: coreDataStack.managedContext)
		coreDataStack.saveContext()
		return card
	}
	
	func deleteCard(card: Card) {
		coreDataStack.managedContext.delete(card)
		coreDataStack.saveContext()
	}
	
	//we'll take this out for now... amounts to moving a card, that is an operation for another day
	/*
	func addTag(card: Card, tag: String) {
		card.addToTags(<#T##value: TagDeck##TagDeck#>)
		coreDataStack.saveContext()
	}
	
	func removeTag(card: Card, tag: String) {
		card.removeTag(tag: tag)
		coreDataStack.saveContext()
	}
	*/
}
