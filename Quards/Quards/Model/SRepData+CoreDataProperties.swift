//
//  SRepData+CoreDataProperties.swift
//  Quards
//
//  Created by Max Fest on 29.08.20.
//
//

import Foundation
import CoreData


extension SRepData {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<SRepData> {
		return NSFetchRequest<SRepData>(entityName: "SRepData")
	}
	
	@NSManaged public var includeInDailyReview: Bool
	@NSManaged public var numReps: Int16
	@NSManaged public var interval: Double
	@NSManaged public var nextDate: Date
	@NSManaged public var averageReviewTime: Double
	@NSManaged public var card: Card
	
}

extension SRepData : Identifiable {
	convenience init(card: Card, context: NSManagedObjectContext) {
		let entity = NSEntityDescription.entity(forEntityName: "SRepData", in: context)
		self.init(entity: entity!, insertInto: context)
		includeInDailyReview = true
		numReps = 0
		interval = 1
		nextDate = Date().addingTimeInterval(24*60*60)
		averageReviewTime = 300
		self.card = card
	}
	
	func updateNextReview(for newInterval: Double) {
		nextDate = Date().addingTimeInterval(Double(newInterval * 24 * 60 * 60))
	}
	
	func updateAverageReviewTime(for newTime: Double) {
		averageReviewTime = (averageReviewTime * (Double(numReps) - 1) + newTime) / Double(numReps)
	}
}
