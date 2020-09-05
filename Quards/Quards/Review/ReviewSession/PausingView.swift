//
//  PausingView.swift
//  Quards
//
//  Created by Max Fest on 28.08.20.
//

import SwiftUI

struct PausingView: View {
	@ObservedObject var session: Session
	var exitSession: () -> Void
	
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.all)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.opacity(0.75)
			
			VStack {
				HStack {
					Spacer()
					Button(action: {
						self.exitSession()
					}) {
						Image(systemName: "xmark.circle.fill")
							.resizable()
							.scaledToFit()
							.frame(width: 40, height: 40)
							.padding(30)
					}
				}
				Spacer()
			}
			
			RoundedRectangle(cornerRadius: 20)
				.stroke(lineWidth: 0.3)
				.frame(width: 350, height: 350)
				.background(Color.white)
			
			if session.spacedRep {
				ProgressTimer(session: session)
					.frame(width: 150, height: 150)
			} else {
				Button(action: {
					session.pomodoro.pausing = false
				}) {
					Image(systemName: "play.fill")
						.resizable()
						.scaledToFit()
						.frame(width: 70, height: 70)
						.foregroundColor(.green)
				}
			}
			
		}
	}
}
