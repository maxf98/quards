//
//  ProgressBar.swift
//  Quards
//
//  Created by Max Fest on 03.09.20.
//

import SwiftUI

struct ProgressBar: View {
	@ObservedObject var session: Session
	
	func color(for index: Int) -> Color {
		if index <= session.cur {
			return Color(session.cards[index].tagDeck?.wrappedColor ?? .white)
		}
		return .gray
	}
	
	var body: some View {
		HStack {
			ForEach(0..<session.cards.count) { index in
				Circle()
					.foregroundColor(color(for: index))
					.scaleEffect(index == session.cur ? 1.5 : 1)
					.animation(.default)
					.frame(width: 15, height: 15)
					.padding(2)
					.overlay(Circle().stroke(lineWidth: 0.5).foregroundColor(.gray))
			}
		}
	}
}
