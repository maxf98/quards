//
//  Thumbnail.swift
//  Quards
//
//  Created by Max Fest on 16.08.20.
//

import SwiftUI

struct Thumbnail: View {
	@ObservedObject var card: Card
	@State var showingOptions = false
	
	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			RoundedRectangle(cornerRadius: 5)
				.foregroundColor(.white)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			
			Image(uiImage: card.frontImg)
				.resizable()
				.scaledToFit()
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.overlay(
					RoundedRectangle(cornerRadius: 5)
						.stroke()
						.frame(minWidth: 30, minHeight: 30))
			
			OptionsButton(showingOptions: $showingOptions)
				.frame(width: 25, height: 25)
				.padding(.trailing, 10)
		}
		.popover(isPresented: $showingOptions) {
			CardOptionsView(card: card, showPopover: $showingOptions)
		}
	}
}

