//
//  QuardHeader.swift
//  Quards
//
//  Created by Max Fest on 25.08.20.
//

import SwiftUI

struct SessionHeader: View {
	@ObservedObject var session: Session
	
	var body: some View {
		ZStack(alignment: .top) {
			LinearGradient(gradient: Gradient(colors: [Color(white: 0.8, opacity: 1), Color(white: 0.95, opacity: 1)]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(.all)
				.frame(maxWidth: .infinity, maxHeight: 140)
			
			HStack {
				ProgressBar(session: session)
					.padding(.leading, 100)
				
				Spacer()
				
				if !(session.pomodoro.pausing) {
					ProgressTimer(session: session)
						.frame(width: 65, height: 65)
				}
				
				Spacer()
			}.padding(.top, 15)
		}
	}
}

