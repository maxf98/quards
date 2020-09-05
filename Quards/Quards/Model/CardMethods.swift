//
//  CardMethods.swift
//  Quards
//
//  Created by Max Fest on 30.08.20.
//

import Foundation
import PencilKit
import CoreData

//MARK: related methods
extension Card {
	class func newInstance(deck: TagDeck, context: NSManagedObjectContext) -> Card {
		let entity = NSEntityDescription.insertNewObject(forEntityName: "Card", into: context) as! Card
		entity.front = PKDrawing().dataRepresentation()
		entity.back = PKDrawing().dataRepresentation()
		entity.id = UUID()
		entity.tagDeck = deck
		entity.createdAt = Date()
		entity.spacedRep = SRepData(card: entity, context: context)
		return entity
	}
	
	func updateDrawing(isFront: Bool, drawing: PKDrawing) {
		if isFront {
			self.front = drawing.dataRepresentation()
		} else {
			self.back = drawing.dataRepresentation()
		}
	}
}

// MARK: accessors for managed properties
extension Card {

	var frontDrawing: PKDrawing {
		return drawingFromData(data: front)
	}
	
	var backDrawing: PKDrawing {
		return drawingFromData(data: back)
	}
	
	func drawingFromData(data: Data?) -> PKDrawing {
		do {
			if let d = data {
				let ret = try PKDrawing(data: d)
				return ret
			}
			return PKDrawing()
		} catch {
			return PKDrawing()
		}
	}
	
	var frontImg: UIImage {
		return imgFromDrawing(drawing: frontDrawing)
	}
	
	var backImg: UIImage {
		return imgFromDrawing(drawing: backDrawing)
	}
	
	func imgFromDrawing(drawing: PKDrawing) -> UIImage {
		let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: drawing.bounds.maxY == .infinity ? 500: drawing.bounds.maxY)
		return drawing.image(from: frame, scale: UIScreen.main.scale)
	}
}
