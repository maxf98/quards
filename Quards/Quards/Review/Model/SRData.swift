//
//  SRData.swift
//  Quards
//
//  Created by Max Fest on 29.08.20.
//

import Foundation

struct SRData {
	var sr: [SRepData]
	
	var dailyReview = [Card]()
	var drTime: Double = 0
	var drCount: Int = 0
	
	init(sr: [SRepData]) {
		self.sr = sr
		getCardsForDailyReview()
	}
	
	//currently gets all cards that are due within the next 2 days...
	mutating func getCardsForDailyReview() {
		var cards = [Card]()
		for cardData in sr {
			if daysFromNow(date: cardData.nextDate) < 2 && cardData.includeInDailyReview {
				cards.append(cardData.card)
			}
		}
		drTime = cards.reduce(0, {x, y in
			x + y.spacedRep.averageReviewTime
		})
		drCount = cards.count
		dailyReview = cards
		printReviewDays()
	}
	
	func printReviewDays() {
		var dayDict = [Int:Int]()
		
		for cardData in sr {
			let daysFrom = daysFromNow(date: cardData.nextDate)
			if dayDict[daysFrom] != nil {
				dayDict[daysFrom]! += 1
			} else {
				dayDict[daysFrom] = 1
			}
		}
		
		for (key, value) in dayDict {
			print("\(key) : \(value)")
		}
	}
	
	func daysFromNow(date: Date) -> Int {
		return Int(ceil(date.timeIntervalSinceNow / Double(24  * 60 * 60)))
	}
}
