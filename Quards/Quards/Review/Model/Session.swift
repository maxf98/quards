//
//  Session.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import Foundation
import PencilKit

class Session: ObservableObject {
	var coreDataStack: CoreDataStack?
	var cards: [Card]
	var cur = 0
	
	var spacedRep: Bool = true
	
	@Published var currentCard: Card?
	@Published var drawing = true
	@Published var frontHidden = false
	
	@Published var pomodoro: Pomodoro
			
	var toolPicker = PKToolPicker()
	
	var smEngine = SREngine()
	
	init() {
		self.cards = [Card]()
		self.pomodoro = Pomodoro()
	}
	
	init(cards: [Card], coreDataStack: CoreDataStack) {
		self.cards = cards
		self.currentCard = cards.first ?? nil
		self.coreDataStack = coreDataStack
		self.pomodoro = Pomodoro()
	}
	
	init(cards: [Card], spacedRep: Bool, coreDataStack: CoreDataStack) {
		self.cards = cards
		self.currentCard = cards.first ?? nil
		self.coreDataStack = coreDataStack
		self.spacedRep = spacedRep
		self.pomodoro = Pomodoro(pomodoroLength: 0, pauseLength: 0)
	}
		
	func nextCard() {
		if cur < cards.count - 1 {
			cur += 1
			self.currentCard = cards[cur]
		} else {
			self.currentCard = nil
		}
		drawing = true
		frontHidden = false
	}
	
	func gradeCard(grade: SRGrade) {
		smEngine.gradeFlashcard(card: currentCard!, grade: grade, reviewTime: Double(pomodoro.currentCardTime))
		coreDataStack?.saveContext()
	}
}
