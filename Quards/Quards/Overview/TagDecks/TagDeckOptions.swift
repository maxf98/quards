//
//  TagDeckOptions.swift
//  Quards
//
//  Created by Max Fest on 31.08.20.
//

import SwiftUI

struct TagDeckOptions: View {
	@Binding var showPopover: Bool
	@Binding var color: Color
	@Binding var includeInDailyReview: Bool
	
	@State var included = true // currently an ugly ass workaround... because I can't get a binding to computed property includeInDailyReview
	// but it works, ay.., we'll see if we keep this...
	
	init(showPopover: Binding<Bool>, color: Binding<Color>, included: Binding<Bool>, delete: @escaping () -> Void) {
		self._showPopover = showPopover
		self._color = color
		_includeInDailyReview = included
		self.delete = delete
		self._included = State(initialValue: included.wrappedValue)
	}
	
	var delete: () -> Void
	
	var body: some View {
		VStack {
			Button(action: {
				self.showPopover = false
				self.delete()
			}) {
				HStack {
					Text("Delete")
						.frame(maxWidth: .infinity, alignment: .leading)
					Spacer()
					Image(systemName: "trash")
						.resizable()
						.scaledToFit()
				}.padding([.leading, .trailing])
			}
			
			Divider()
				
			Toggle("Include in daily review", isOn: $included)
				.toggleStyle(CheckToggleStyle())
				.padding([.leading, .trailing])
				.padding([.top, .bottom], 5)
				.foregroundColor(.blue)
			
			Divider()
			
			ColorPicker("Change tag color", selection: $color)
				.foregroundColor(.blue)
				.padding([.leading, .trailing])
		}
		.onDisappear {
			includeInDailyReview = included
		}
	}
}

