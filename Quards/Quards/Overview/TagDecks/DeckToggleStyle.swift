//
//  DeckToggleStyle.swift
//  Quards
//
//  Created by Max Fest on 04.09.20.
//

import SwiftUI

struct DeckToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		Button(action: {configuration.isOn.toggle() }) {
			Image(systemName: configuration.isOn ? "folder.circle.fill" : "folder.circle")
				.resizable()
				.scaledToFit()
				.frame(width: 30, height: 30)
				.scaleEffect(configuration.isOn ? 1.1 : 1)
				.animation(.easeInOut)
				.buttonStyle(PlainButtonStyle())
		}
	}
}
