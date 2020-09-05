//
//  ResultsView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI

struct ResultsView: View {
	var session: Session
	var exitSession: () -> Void
		
	var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.all)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			
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
			
			Text("Focussed time: \(session.pomodoro.workTimeString)")
		}
	}
}
