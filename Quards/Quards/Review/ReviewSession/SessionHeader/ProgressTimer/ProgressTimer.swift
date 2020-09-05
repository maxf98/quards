//
//  ProgressTimer.swift
//  Quards
//
//  Created by Max Fest on 28.08.20.
//

import SwiftUI

struct ProgressTimer: View {
	@ObservedObject var session: Session	
	@State var showPauseBtn = false
	
	var body: some View {
		ZStack {
			ProgressCircle(pomodoro: $session.pomodoro)
			
			TimerView(pomodoro: $session.pomodoro, showPauseBtn: $showPauseBtn)
				.overlay(
					Group {
						if !(session.pomodoro.pausing) && showPauseBtn {
							Button(action: {
								session.pomodoro.timerRanOut()
								showPauseBtn = false
							}) {
								Image(systemName: "pause.fill")
									.resizable()
									.scaledToFit()
									.opacity(0.7)
									.buttonStyle(PlainButtonStyle())
									.foregroundColor(.gray)
							}
						} else if session.pomodoro.pausing && showPauseBtn {
							Button(action: {
								session.pomodoro.timerRanOut()
							}) {
								Image(systemName: "play.fill")
									.resizable()
									.scaledToFit()
									.opacity(0.8)
									.buttonStyle(PlainButtonStyle())
									.foregroundColor(.green)
							}
						} else {
							EmptyView()
						}
					})
		}
	}
}

