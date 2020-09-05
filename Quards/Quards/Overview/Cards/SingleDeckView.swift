//
//  SingleDeckView.swift
//  Quards
//
//  Created by Max Fest on 05.08.20.
//

import SwiftUI

struct SingleDeckView: View {
	@EnvironmentObject var quardsModel: QuardsModel
	@EnvironmentObject var tabController: TabBarController
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	
	@ObservedObject var tagDeck: TagDeck
	let columns = [GridItem(.adaptive(minimum: 175))]
	
	@State var selectedCard: Card?
	
	var body: some View {
		let showingCard = Binding<Bool>(
			get: {
				selectedCard != nil
			}, set: {
				selectedCard = $0 ? selectedCard : nil
			})
		
		return ZStack {
			VStack {
				ScrollView {
					LazyVGrid(columns: columns, spacing: 20) {
						AddEntityButton()
							.foregroundColor(Color(tagDeck.complementaryColor))
							.onTapGesture {
								selectedCard = quardsModel.addNewCard(deck: tagDeck)
							}
						
						ForEach(tagDeck.allCards, id: \.self.objectID) { card in
							Thumbnail(card: card)
								.padding(3)
								.onTapGesture {
									withAnimation {
										selectedCard = card
									}
								}
						}
					}
				}
				.padding()
			}.fullScreenCover(isPresented: showingCard) {
				if let card = selectedCard {
					CardView(card: card, showingCard: showingCard)
						.padding()
				}
			}
		}
	}
}
