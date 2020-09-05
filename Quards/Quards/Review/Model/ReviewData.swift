//
//  ReviewData.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import Foundation
import CoreData

class ReviewData: ObservableObject {
	
	var coreDataStack: CoreDataStack
	
	@Published var srData = SRData(sr: [SRepData]())
	
	var currentSession: Session?
	
	init(coreDataStack: CoreDataStack) {
		self.coreDataStack = coreDataStack
		self.srData = SRData(sr: getSRData())
	}
	
	@Published var selectedDecks = Set<TagDeck>()
	
	func getCardsForSelectedDecks() -> [Card] {
		var cards = Set<Card>()
		for deck in selectedDecks {
			cards.formUnion(deck.wrappedCards)
		}
		return Array(cards)
	}
	
	func getSRData() -> [SRepData]{
		let fetchRequest: NSFetchRequest<SRepData> = SRepData.fetchRequest()
		
		var results = [SRepData]()
		
		do {
			results = try coreDataStack.managedContext.fetch(fetchRequest)
		} catch let error as NSError {
			print("Fetch error: \(error) description: \(error.userInfo)")
		}
		
		return results
	}
		
	func refreshSR() {
		srData.getCardsForDailyReview()
	}
	
	func newDailyReviewSession() {
		currentSession = Session(cards: srData.dailyReview, coreDataStack: coreDataStack)
	}
	
	func newSessionFromSelectedDecks() {
		currentSession = Session(cards: getCardsForSelectedDecks(), spacedRep: false, coreDataStack: coreDataStack)
		selectedDecks = Set<TagDeck>()
	}
	
}
