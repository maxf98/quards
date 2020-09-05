//
//  TagDeckMethods.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//

import Foundation
import CoreData
import UIKit

//General accessors to stored properties
extension TagDeck {
	class func newRoot(context: NSManagedObjectContext) -> TagDeck {
		let entity = NSEntityDescription.insertNewObject(forEntityName: "TagDeck", into: context) as! TagDeck
		entity.color = UIColor.random().encode()
		entity.id = UUID()
		entity.createdAt = Date()
		return entity
	}
	
	class func newInstance(deck: TagDeck, context: NSManagedObjectContext) -> TagDeck {
		let entity = NSEntityDescription.insertNewObject(forEntityName: "TagDeck", into: context) as! TagDeck
		entity.parent = deck
		entity.color = UIColor.random().encode()
		entity.id = UUID()
		entity.createdAt = Date()
		return entity
	}
	
	var includeInDailyReview: Bool {
		get {
			for card in allCards {
				if card.spacedRep.includeInDailyReview {
					return true
				}
			}
			return false
		}
		set {
			for card in allCards {
				card.spacedRep.includeInDailyReview = newValue
			}
		}
	}
	
	var wrappedColor: UIColor {
		get {
			return UIColor.color(withData: self.color)
		}
		set {
			self.color = newValue.encode()
		}
	}
	
	var secondaryColor: UIColor {
		let comps = wrappedColor.cgColor.components!
		if comps.count < 3  {
			return UIColor.black
		}
		let brightness: CGFloat = ((comps[0] * 299) + (comps[1] * 587) + (comps[2] * 114)) / 1000
		return brightness > 0.3 ? UIColor.black : UIColor.white
	}
	
	var complementaryColor: UIColor {
		let comps = wrappedColor.cgColor.components!
		if comps.count < 3  {
			return UIColor.black
		}
		return UIColor(red: 1 - comps[0], green: 1 - comps[1], blue: 1 - comps[2], alpha: 1)
	}
	
	var wrappedCards: [Card] {
		return (cards.allObjects as! [Card]).sorted(by: {
			$0.createdAt < $1.createdAt
		})
	}
	
	var wrappedChildren: [TagDeck] {
		return (children.allObjects as! [TagDeck]).sorted(by: {
			$0.createdAt < $1.createdAt
		})
	}
	
	var allCards: [Card] {
		var all = Set<Card>()
		var queue = [self]
		while !queue.isEmpty {
			let node = queue.popLast()!
			all.formUnion(node.wrappedCards)
			queue.append(contentsOf: node.wrappedChildren)
		}
		return Array(all).sorted(by: { $0.createdAt < $1.createdAt })
	}
}

extension CGFloat {
	static func random() -> CGFloat {
		return CGFloat(arc4random()) / CGFloat(UInt32.max)
	}
}

extension UIColor {
	static func random() -> UIColor {
		return UIColor(
			red:   .random(),
			green: .random(),
			blue:  .random(),
			alpha: 1.0
		)
	}
	
	class func color(withData data:Data) -> UIColor {
		do {
			return try NSKeyedUnarchiver.unarchivedObject(ofClass: self, from: data)!
		} catch {
			return UIColor.white
		}
	}
	
	func encode() -> Data {
		do {
			return try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true)
		} catch {
			fatalError("storing a color... wgaf")
		}
	}
}
