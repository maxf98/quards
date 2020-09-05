//
//  ProgressCircle.swift
//  Quards
//
//  Created by Max Fest on 28.08.20.
//

import SwiftUI

struct ProgressCircle: View {
	@Binding var pomodoro: Pomodoro
	
	var progress: Float {
		Float(pomodoro.timeRemaining) / Float(pomodoro.maxTime)
	}
	
	var body: some View {
		ZStack {
			Circle()
				.stroke(lineWidth: 10.0)
				.opacity(0.3)
				.foregroundColor(pomodoro.timeRemaining > 0 ? .red : .green)
			
			Circle()
				.trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
				.stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
				.foregroundColor(pomodoro.timeRemaining > 0 ? .red : .green)
				.rotationEffect(Angle(degrees: 270.0))
				.animation(.linear)
		}
	}
}


