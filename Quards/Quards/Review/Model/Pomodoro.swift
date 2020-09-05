//
//  Pomodoro.swift
//  Quards
//
//  Created by Max Fest on 28.08.20.
//

import Foundation

struct Pomodoro {
	var totalWorkTime = 0
	var timeRemaining: Int
	var pausing = false
	
	var currentCardTime = 0
	
	var pomodoroLength: Int
	var pauseLength: Int
	var maxTime: Int {
		pausing ? pauseLength : pomodoroLength
	}
	
	init() {
		pomodoroLength = 30
		pauseLength = 10
		timeRemaining = 30
	}
	
	init(pomodoroLength: Int, pauseLength: Int) {
		self.pomodoroLength = pomodoroLength
		self.pauseLength = pauseLength
		self.timeRemaining = pomodoroLength
	}
	
	mutating func timerRanOut() {
		timeRemaining = pausing ? pomodoroLength : pauseLength
		pausing.toggle()
	}
	
	mutating func step() {
		totalWorkTime += pausing ? 0 : 1
		currentCardTime += pausing ? 0 : 1
		timeRemaining -= 1
	}
	
	mutating func nextCard() -> Int {
		let temp = currentCardTime
		currentCardTime = 0
		return temp
	}
	
	var formattedWorkTime: (Int, Int, Int) {
		return ((totalWorkTime / 3600), ((totalWorkTime % 3600) / 60), ((totalWorkTime % 3600) % 60))
	}
	
	var workTimeString: String {
		let t = formattedWorkTime
		return t.0 == 0 ? "\(t.1) mins, \(t.2) seconds" : "\(t.0) hrs, \(t.1) mins, \(t.2) seconds" 
	}
}
