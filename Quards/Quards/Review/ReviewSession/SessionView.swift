//
//  SessionView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI

struct SessionView: View {
	
	@ObservedObject var session: Session
	var exitSession: () -> Void
	
	var body: some View {
		ZStack() {
			Color.white.edgesIgnoringSafeArea(.all).frame(maxWidth: .infinity, maxHeight: .infinity)
			
			if session.currentCard != nil {
				VStack(spacing: -30) {
					SessionHeader(session: session)
					
					QuardView(session: session, exit: exitSession)
						.grayscale(session.pomodoro.pausing ? 0.8 : 0)
						.blur(radius: session.pomodoro.pausing ? 2 : 0)
						.disabled(session.pomodoro.pausing)
						.clipShape(RoundedRectangle(cornerRadius: 30))
				}
			} else {
				ResultsView(session: session, exitSession: exitSession)
			}
			
			if session.pomodoro.pausing {
				PausingView(session: session, exitSession: exitSession)
			}
		}
	}
}
