//
//  Pomodoro.swift
//  Quards
//
//  Created by Max Fest on 28.08.20.
//

import SwiftUI

struct TimerView: View {
	@Binding var pomodoro: Pomodoro
	@Binding var showPauseBtn: Bool
	@State var toggledPauseBtn = 0
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	func timerFired() {
		if !(pomodoro.pausing && pomodoro.timeRemaining <= 1) {
			pomodoro.step()
			if showPauseBtn {
				toggledPauseBtn += 1
			}
		} else {
			pomodoro.timeRemaining = 0
			withAnimation {
				showPauseBtn = true
			}
		}
		if toggledPauseBtn >= 3 {
			withAnimation {
				showPauseBtn = false
			}
			toggledPauseBtn = 0
		}
	}
	
	var body: some View {
		return GeometryReader { geometry in
			Text("\(abs(pomodoro.timeRemaining))")
				.foregroundColor(pomodoro.timeRemaining > 0 ? .red : .green)
				.onReceive(timer, perform: { _ in
					timerFired()
				})
				.position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
				.frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.6)
				.onTapGesture {
					withAnimation {
						showPauseBtn = true
					}
				}
		}
	}
}

