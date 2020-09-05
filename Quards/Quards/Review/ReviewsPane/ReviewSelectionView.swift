//
//  ReviewSelectionView.swift
//  Quards
//
//  Created by Max Fest on 24.08.20.
//

import SwiftUI

struct ReviewSelectionView: View {
	@FetchRequest (entity: TagDeck.entity(), sortDescriptors: [
									NSSortDescriptor(keyPath: \TagDeck.createdAt, ascending: true)]) var decks: FetchedResults<TagDeck>
	
	@Binding var selectedDecks: Set<TagDeck>
	
	var startReview: () -> Void
	
	var body: some View {
		VStack {
			Text("Session Configurator")
				.foregroundColor(.gray)
				.fontWeight(.bold)
				.frame(maxWidth : .infinity, alignment: .trailing)
			
			TagHierarchy(selectedDecks: $selectedDecks, onCommit: {
				startReview()
			})
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding()
			.overlay(
				RoundedRectangle(cornerRadius: 15)
					.stroke(lineWidth: 0.5))
		}
	}
}


struct HorizontalLine: View {
	var body: some View {
		Rectangle()
			.frame(height: 1)
			.frame(maxWidth: .infinity)
			.foregroundColor(.black)
	}
}
