//
//  AddEntityButton.swift
//  Quards
//
//  Created by Max Fest on 02.09.20.
//

import SwiftUI

struct AddEntityButton: View {
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 20)
				.stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
				.padding(1.5)
			
			VStack {
				Spacer()
				HStack {
					Spacer()
					Image(systemName: "plus")
						.resizable().scaledToFit()
						.padding(15)
						.frame(maxWidth: 70)
					Spacer()
				}
				Spacer()
			}
		}
	}
}

struct AddEntityButton_Previews: PreviewProvider {
	static var previews: some View {
		AddEntityButton()
	}
}
