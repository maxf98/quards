//
//  CheckToggleStyle.swift
//  Quards
//
//  Created by Max Fest on 04.09.20.
//

import SwiftUI

struct CheckToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.label
				.fixedSize(horizontal: true, vertical: false)
				.padding(.trailing, 20)
			
			Button(action: { configuration.isOn.toggle() }) {
				Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
					.resizable()
					.scaledToFit()
					.frame(width: 20)
					.scaleEffect(configuration.isOn ? 0.9 : 1.1)
			}
		}
	}
}
