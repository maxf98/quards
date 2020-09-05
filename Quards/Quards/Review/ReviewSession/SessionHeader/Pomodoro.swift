//
//  Pomodoro.swift
//  Quards
//
//  Created by Max Fest on 28.08.20.
//

import SwiftUI

struct Timer: View {
	@Binding var timeRemaining: Int
	@Binding var timerRanOut
	
	var body: some View {
		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
	}
}

struct Pomodoro_Previews: PreviewProvider {
	static var previews: some View {
		Timer()
	}
}
