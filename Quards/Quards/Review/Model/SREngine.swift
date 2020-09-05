//
//  SMEngine.swift
//  Quards
//
//  Created by Max Fest on 29.08.20.
//

import Foundation

class SREngine {

	public init() {}
	
	public func gradeFlashcard(card: Card, grade: SRGrade, reviewTime: Double) {
		let sr = card.spacedRep
		let newInterval = sr.interval * grade.intervalMultiplier
		sr.interval = newInterval
		sr.updateNextReview(for: newInterval)
		sr.numReps += 1
		sr.updateAverageReviewTime(for: reviewTime)
		
		print(sr.nextDate)
	}
}
